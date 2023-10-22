import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/constant/toaster.dart';
import 'package:nftwist/main.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/color.dart';
import '../../../../../services/apiHandler.dart';
import '../../../../../services/locator.dart';
import '../../../../../services/navigation_service.dart';
import '../../../../../services/pick_image.dart';
import '../../../../../widget/button.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);
  static const route = "verify_screen";

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool checkValue = false;
  String? doc='passport';
  List? docList=["passport","id card"];
  File? frontSide;
  File? backSide;
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Verify",
      ),
      body: LoaderPage(
        loading: loading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Container(height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38),
                    border: Border.all(width: 2, color: const Color(0xffE6E6E6))
                ),
                margin: const EdgeInsets.only(top:  16,),
                child: DropdownButtonFormField<String>(
                  value: doc,icon: Container(),dropdownColor: blackColor2,
                  items: docList!.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.toString().capitalize()),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                    doc=newValue??doc;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Document",
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                height: 166,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2, color: const Color(0xffE6E6E6))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Document's Front Side",
                        style: w_500.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Button_2(
                        buttonTxt: "Upload Documents",
                        normalBorder: frontSide==null,
                        function: () {
                          showModalBottomSheet(backgroundColor: blackColor,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/icons/camera.svg",height: 25,width: 25,
                                      ),
                                      title:   Text('Camera',style: w_500,),onTap: () async {
                                      try{
                                        setState(() {
                                          loading = true;
                                        });
                                        locator<NavigationService>().goBack();
                                        var result =
                                        await PickImage(source: ImageSource.camera)
                                            .uploadImage();
                                        if (result != null) {
                                          setState(() {
                                            loading = false;
                                            frontSide=File(result.path);
                                          });
                                        }
                                      }catch(_){
                                        setState(() {
                                          loading=false;
                                        });
                                      }
                                    },
                                    ),
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/icons/gallery.svg",height: 25,width: 25,
                                      ),
                                      title:   Text('Gallery',style: w_500,),onTap: () async {

                                      try{
                                        setState(() {
                                          loading = true;
                                        });
                                        locator<NavigationService>().goBack();
                                        var result =
                                        await PickImage(source: ImageSource.gallery)
                                            .uploadImage();
                                        if (result != null) {
                                          setState(() {
                                            loading = false;
                                            frontSide=File(result.path);
                                          });
                                        }
                                      }catch(_){
                                        setState(() {
                                          loading=false;
                                        });
                                      }
                                    },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        verticalPadding: 20,
                        horizontalPadding: 20,
                      ),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                height: 166,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2, color: const Color(0xffE6E6E6))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Document's Back Side",
                        style: w_500.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Button_2(
                        buttonTxt: "Upload Documents",
                        normalBorder: backSide==null,
                        function: () {
                          showModalBottomSheet(backgroundColor: blackColor,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/icons/camera.svg",height: 25,width: 25,
                                      ),
                                      title:   Text('Camera',style: w_500,),onTap: () async {
                                      try{
                                        setState(() {
                                          loading = true;
                                        });
                                        locator<NavigationService>().goBack();
                                        var result =
                                        await PickImage(source: ImageSource.camera)
                                            .uploadImage();
                                        if (result != null) {
                                          setState(() {
                                            loading = false;
                                            backSide=File(result.path);
                                          });
                                        }
                                      }catch(_){
                                        setState(() {
                                          loading=false;
                                        });
                                      }
                                    },
                                    ),
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/icons/gallery.svg",height: 25,width: 25,
                                      ),
                                      title:   Text('Gallery',style: w_500,),onTap: () async {

                                      try{
                                        setState(() {
                                          loading = true;
                                        });
                                        locator<NavigationService>().goBack();
                                        var result =
                                        await PickImage(source: ImageSource.gallery)
                                            .uploadImage();
                                        if (result != null) {
                                          setState(() {
                                            loading = false;
                                            backSide=File(result.path);
                                          });
                                        }
                                      }catch(_){
                                        setState(() {
                                          loading=false;
                                        });
                                      }
                                    },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        verticalPadding: 20,
                        horizontalPadding: 20,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 167,
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: blackColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // visualDensity: const VisualDensity(horizontal: -4, vertical: 1),
                    side: const BorderSide(color: whiteColor2),
                    activeColor: whiteColor2,
                    checkColor: blackColor,
                    value: checkValue,
                    onChanged: (bool? value) {
                      setState(() {
                        checkValue = value!;
                      });
                    },
                  ),
                  Expanded(
                      child: Text(
                    "I acknowledge that the information uploaded is correct.",
                    style: w_400.copyWith(fontSize: 12),
                    maxLines: 2,
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Button(active: checkValue&&!loading,
                buttonTxt: "Start The Verification Process", function: () async {

                 if(backSide==null||frontSide==null){
                   locator<Toaster>().showToaster(
                       msg: "Upload Front and Back Documents",bottomMargin: .67,
                       toasterDurationMilli: 1200,
                       loadingDuration: 4);
                 }else{    setState(() {
                   loading =true;
                 });
                 loading=await Provider.of<Auth>(context,listen: false).updateDoc(context,doc_front:await uploadRequest(frontSide?.path),
                     document_back:await uploadRequest(backSide?.path),doc_type: docList?.indexWhere((element) => element==doc));
                 setState(() {
                 });
                 }

                }),
            SizedBox(
              height: 10,
            ),
            Text(
              "The verification process may take up to 48 hours.",
              style: w_400.copyWith(fontSize: 12),
              maxLines: 2,
            ),

          ],
        ),
      ),
    );
  }
}
