import 'package:flutter/material.dart';
import 'package:nftwist/constant/style.dart';

import '../services/api_response_handler.dart';
import 'color.dart';
class GetCity extends StatefulWidget {
  final String countryShortName;
  const GetCity({Key? key, required this.countryShortName}) : super(key: key);

  @override
  State<GetCity> createState() => _GetCityState();
}
class _GetCityState extends State<GetCity> {
  final TextEditingController _searchController=TextEditingController();
  List? _cityList;
  List? _list;
  List? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() {
       search(_searchController.text);
    });
    Future.delayed(Duration.zero).then((value) async => data=await ApiResponse().getCity(countryShortname: widget.countryShortName)).then((value) =>      setState(() {
       _list= data?.map((data) => data["name"]).toList();
      _cityList=_list;
    }));
  }

  search(string){
    setState(() {
      if(string!=null&&string!=''){
        _list=_cityList?.where((element) => element.toString().toLowerCase().startsWith(string.toString().toLowerCase())).toList();
      }else{
        _list=_cityList;
      }    });
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final height =
        device - (statusBarHeight + (kToolbarHeight / 1.5));

    Color? _backgroundColor =Theme.of(context).bottomSheetTheme.backgroundColor;
    if (_backgroundColor == null) {
      if (Theme.of(context).brightness == Brightness.light) {
        _backgroundColor = Colors.white;
      } else {
        _backgroundColor = Colors.black;
      }
    }

    const BorderRadius _borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    );

    return Container(
      height: height,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: _borderRadius,
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: TextField(
              style: const TextStyle(
                  fontSize: 16,
                  color: blackColor),
              controller: _searchController,
              decoration:
              InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ),
                ),
              ),
              // onChanged: _filterSearchResults,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (_list != null) ...[
                  ..._list!
                      .map((name) =>  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context,name);
                      },
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 20,),
                          Expanded(
                            child: Text(
                              name,style: w_500.copyWith(color: blackColor,fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                      .toList(),
                ]else  const Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: Center(child: SizedBox(height: 30,width: 30,child:  CircularProgressIndicator(),)),),
                // ..._filteredList
                //     .map<Widget>((country) => _listRow(country))
                //     .toList(),
              ],
            ),
          ),
        ],
      ) ,
    );
  }
}