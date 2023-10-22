import 'package:flutter/material.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/main.dart';

import 'color.dart';

class GetCountry extends StatefulWidget {
  const GetCountry({Key? key,}) : super(key: key);

  @override
  State<GetCountry> createState() => _GetCountryState();
}
class _GetCountryState extends State<GetCountry> {
  final TextEditingController _searchController=TextEditingController();
  List? _list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _list=country;
    });
    _searchController.addListener(() {
      search(_searchController.text);
    });

  }
  search(string){
    setState(() {
      if(string!=null&&string!=''){
        _list=country?.where((element) => element['name'].toString().toLowerCase().startsWith(string.toString().toLowerCase())).toList();
      }else{
        _list=country;
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
        children: <Widget>[
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
                      .map<Widget>((currency) =>  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context,currency);
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(width: 15,),
                          Text(
                            currency['emoji'].toString(),
                            style: w_500.copyWith(color: blackColor,fontSize: 25),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Text(
                              currency['name'].toString(),style: w_500.copyWith(color: blackColor,fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                      .toList(),
                ]else  Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Center(child: Text("No Country Found",style: w_500.copyWith(color: blackColor2),)),),
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