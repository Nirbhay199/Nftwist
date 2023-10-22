import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/services/pick_image.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/get_country.dart';
import '../../../constant/style.dart';
import '../../../provider/auth.dart';
import '../../../provider/user.dart';
import '../../../services/apiHandler.dart';
import '../../../widget/button.dart';
import '../../../widget/textfiels/textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const route = "edit_profile";
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool loading =false;
  bool removeProfile=false;
  bool removeCoverProfile=false;
  File? coverImage;
  File? profile;
  final TextEditingController _phoneNo = TextEditingController();
  String countryCode = "971";
  // var flag = '🇦🇪';
  DateTime? dateOfBirth;
  final TextEditingController _firstNameController= TextEditingController();
 final TextEditingController _lastNameController= TextEditingController();
 final TextEditingController _userController= TextEditingController();
 final TextEditingController _descriptionController= TextEditingController();
 final TextEditingController _webSideController= TextEditingController();
  String? dropDownValue;
  List<String> items = ['Male', 'Female', 'Other'];
  @override
  void initState() {
    var user=Provider.of<User>(context,listen: false).user;
    super.initState();
    _firstNameController.text=user?.first_name??"";
    _lastNameController.text=user?.last_name??"";
    _userController.text=user?.user_name??"";
    _descriptionController.text=user?.bio??"";
    _webSideController.text=user?.personal_link??"";
    _phoneNo.text=user?.phone_no==null?'':user!.phone_no.toString();
    countryCode=user?.country_code??'';
    dateOfBirth=user?.dob==null?null:DateTime.parse(user!.dob!);
      dropDownValue=user?.gender;
  }

  @override
  Widget build(BuildContext context) {
    var user=Provider.of<User>(context).user;
    var fun=Provider.of<Auth>(context,listen: false);
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Edit Profile",
      ),
      body: LoaderPage(
        loading: loading,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 290,
              child: Stack(
                children: [
                  coverImage!=null?
                  Image.file(coverImage!,
                    height: 240,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,height: 240,);
                    },
                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                      if(wasSynchronouslyLoaded==true) {
                        return const Center(child: CupertinoActivityIndicator(color: whiteColor,));
                      } else {
                        return child;
                      }
                    }, ):   CachedNetworkImage(imageUrl:
                    "$imageBaseUrl${user?.cover_image}",
                    height: 240,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    placeholder: (context, imageProvider) {
                      return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00FFDD),
                            Color(0xFF2BCAE4),
                            Color(0xFF6383EE),
                            Color(0xFF904BF5),
                            Color(0xFFB123FA),
                            Color(0xFFC50AFE),
                            Color(0xFFCC01FF),
                          ],
                          stops: [
                            0.0,
                            0.1615,
                            0.3281,
                            0.5052,
                            0.6771,
                            0.8229,
                            1.0,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:
                              profile!=null?
                              Image.file(profile!,
                                height: 240,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,height: 240,);
                                },
                                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                  if(wasSynchronouslyLoaded==true) {
                                    return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                                  } else {
                                    return child;
                                  }
                                }, ):         CachedNetworkImage(imageUrl:
                              "$imageBaseUrl${user?.profile_pic}",
                                height: 240,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                placeholder: (context, imageProvider) {
                                  return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                                },
                                errorWidget: (context, url, error) {
                                  return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                                },
                              )  ),
                          Positioned(bottom: 1,left: 82,
                            child: InkWell(
                              onTap: ()   {
                                // try{
                                //   setState(() {
                                //     loading = true;
                                //   });
                                //   var result =
                                //   await PickImage(source: ImageSource.gallery)
                                //       .uploadImage();
                                //   if (result != null) {
                                //     setState(() {
                                //       loading = false;
                                //       profile=File(result.path);
                                //     });
                                //   }
                                // }catch(_){
                                //   setState(() {
                                //     loading=false;
                                //   });
                                // }
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
                                                  profile=File(result.path);
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
                                                  profile=File(result.path);
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
                                            onTap:(){
                                              setState(() {
                                                 removeProfile=true;
                                                 profile=File("path");
                                                 locator<NavigationService>().goBack();
                                              });
                                            },
                                            leading: SvgPicture.asset(
                                              "assets/icons/delete.svg",height: 25,width: 25,
                                            ),
                                            title: Text('Remove',style: w_500,),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                          },
                              child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  height: 33,
                                  width: 33,
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF00FFDD),
                                        Color(0xFF2BCAE4),
                                        Color(0xFF6383EE),
                                        Color(0xFF904BF5),
                                        Color(0xFFB123FA),
                                        Color(0xFFC50AFE),
                                        Color(0xFFCC01FF),
                                      ],
                                      stops: [
                                        0.0,
                                        0.1615,
                                        0.3281,
                                        0.5052,
                                        0.6771,
                                        0.8229,
                                        1.0,
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/camera-fill.svg",
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(right: 2,bottom: 68,
                    child: InkWell(
                      onTap: () async {
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
                                          coverImage=File(result.path);
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
                                          coverImage=File(result.path);
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
                                    onTap:(){
                                      setState(() {
                                        removeCoverProfile=true;
                                        coverImage=File("path");
                                        locator<NavigationService>().goBack();
                                      });
                                    },
                                    leading: SvgPicture.asset(
                                      "assets/icons/delete.svg",height: 25,width: 25,
                                    ),
                                    title: Text('Remove',style: w_500,),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          height: 33,
                          width: 33,
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF00FFDD),
                                Color(0xFF2BCAE4),
                                Color(0xFF6383EE),
                                Color(0xFF904BF5),
                                Color(0xFFB123FA),
                                Color(0xFFC50AFE),
                                Color(0xFFCC01FF),
                              ],
                              stops: [
                                0.0,
                                0.1615,
                                0.3281,
                                0.5052,
                                0.6771,
                                0.8229,
                                1.0,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/camera-fill.svg",
                          )),
                    ),
                  )
                ],
              ),
            ),
            TextFieldForm(
             tfController:_firstNameController,
             hintText: "First name",topPadding: 24,),
            TextFieldForm(
             tfController:_lastNameController,
             hintText: "Last name",topPadding: 16,),
            TextFieldForm(
             tfController:TextEditingController(text: user?.email),
             readOnly: true,
             postfix: const IconButton(onPressed: null, icon:Icon(Icons.verified,color: Colors.blue,),iconSize: 20,),
             hintText: "Email",topPadding: 16,),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  border:
                  Border.all(width: 2, color: const Color(0xffE6E6E6))),
              margin: const EdgeInsets.only(top: 16, left: 20, right: 20),
              // padding: EdgeInsets.only(left: 0,),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      var a = await showModalBottomSheet(
                          context: context,
                          builder: (context) => const GetCountry());
                      setState(() {
                        countryCode = a['phone'];
                        // flag = a['emoji'];
                      });
                    },
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 13,
                        ),
                        Text("+$countryCode",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                        const SizedBox(
                          width: 7,
                        ),
                        const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                      height: 30,
                      child: VerticalDivider(
                        width: 8,
                        thickness: 2,
                      )),
                  Expanded(
                    child: TextFormField(
                      cursorColor: const Color(0xff5E686B),
                      cursorHeight: 20,
                      cursorWidth: 1.5,
                      onTap: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      },
                      controller: _phoneNo,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                        FilteringTextInputFormatter.digitsOnly,

                      ],
                      style: w_500.copyWith(
                        color: textFieldColor,
                        fontSize: 16,
                        letterSpacing: .5,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.fromLTRB(14, 16, 14, 12),
                        hintText: "Phone no.",
                        hintStyle: w_500.copyWith(
                          color: textFieldColor,
                          fontSize: 16,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

        Row(
          children: [
            Expanded(
              child: InkWell(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        DateTime? data = await showDatePicker(
                            context: context,
                            initialDate:
                            dateOfBirth ?? DateTime(1999, 05, 28),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now());
                        if (data != null) {
                          setState(() {
                            dateOfBirth = data;
                          });
                        }
                      },
                      child:      Container(

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(38),
                              border:
                              Border.all(width: 2, color: const Color(0xffE6E6E6))),
                          margin: const EdgeInsets.only(top: 16, left: 20, right: 10),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 13,
                              ),
                              const Icon(Icons.calendar_month,color: Colors.white, size: 18),
                              const SizedBox(
                                width: 14,
                              ),
                              Text(
                                dateOfBirth != null
                                    ? DateFormat("yyyy/MM/dd")
                                    .format(dateOfBirth!)
                                    : "Birth",
                                style: w_500.copyWith(
                                  color: textFieldColor,
                                  fontSize: 16,
                                  letterSpacing: .5,
                                ),
                              )
                            ],
                          ),
                        ),

                    ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  border:
                  Border.all(width: 2, color: const Color(0xffE6E6E6))),
                 margin: const EdgeInsets.only(top: 16, right: 20),
              // padding: EdgeInsets.symmetric(vertical: 14),
              child:Row(
                children: [
                  const SizedBox(
                    width: 13,
                  ),
                  const Icon(Icons.person,color: Colors.white, size: 18),
                  const SizedBox(
                    width: 14,
                  ),
                  DropdownButton<String>(
                    underline: Container(),
                    icon:   const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.keyboard_arrow_down_rounded,color: whiteColor,),
                    ),
                    value: dropDownValue,
                    hint: Text("Gender",style: w_500.copyWith(
                      color: textFieldColor,
                      fontSize: 16,
                      letterSpacing: .5,
                    )),
                    onChanged: (newValue) {
                      setState(() {
                        dropDownValue = newValue;
                        items.remove(newValue);
                        items.insert(0, newValue!);
                      });
                    },
                    dropdownColor: blackColor,
                    items: items.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value.toUpperCase(),
                            child: Text(value,style: w_500.copyWith(
                              color: textFieldColor,
                              fontSize: 16,
                              letterSpacing: .5,
                            )),
                          );
                        }).toList(),
                  ),

                ],
              ),
            ),
          ],
        ),

            TextFieldForm( tfController:_userController,
             hintText: "Username",topPadding: 16,leading: Text(
             "@",
             style:w_400.copyWith(fontWeight: FontWeight.w500),
              ),isLeading: true,),
              TextFieldForm(
             tfController:_descriptionController,
             hintText: "Please describe here...",
             minLines: 5,
             maxLines: 5,
             borderRadius: 16,
             topPadding: 16,
              ),
            TextFieldForm(
              tfController: _webSideController,
             hintText: "Website",topPadding: 16,bottomPadding: 20,)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(0,16,0,34),
        color: blackColor,
        child: Button(buttonTxt: "Save Changes", function:loading?null: () async{
          setState(() {
            loading =true;
          });
          loading=await fun.editProfile(context,
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
              userName: _userController.text.trim(),
              cover_image: removeCoverProfile?null:coverImage==null?user?.cover_image:await uploadRequest(coverImage?.path),
              profile_pic: removeProfile?null:profile==null?user?.profile_pic:await uploadRequest(profile?.path),
              phone_no: user?.phone_no,gender: dropDownValue,
              country: user?.country,
              country_code: user?.country_code,
              state: user?.state,
              dob: dateOfBirth.toString(),
              personal_link: _webSideController.text.trim(),
              bio: _descriptionController.text.trim());
          setState(() {
          });
        }),
      ),
    );
  }
}
