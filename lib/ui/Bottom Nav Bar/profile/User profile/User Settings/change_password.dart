import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../widget/textfiels/textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
 static const route ="change_password";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController new_pass=TextEditingController();
  final TextEditingController confirm_pass=TextEditingController();
  final TextEditingController old_pass=TextEditingController();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: "Change Password",
      ),
      body:  LoaderPage(
        loading: loading,
        child: Column(children: [
          TextFieldForm(hintText: "Old password",topPadding: 24,tfController: old_pass,
          isPass: true),
          TextFieldForm(hintText: "New password",topPadding: 16,tfController: new_pass,
          isPass: true),
          TextFieldForm(hintText: "Confirm new password",topPadding: 16,tfController:confirm_pass ,
          isPass: true),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: blackColor,
            child: Button(buttonTxt: "Update Password", function: () {
              setState(() {
                loading=true;
              });
              Provider.of<Auth>(context,listen: false).updatePassword(old_pass.text, new_pass.text,confirm_pass.text).then((_){
                setState(() {
                  loading=false;
                });
              });
            }),
          ),

        ]),
      ) ,
    );
  }
}
