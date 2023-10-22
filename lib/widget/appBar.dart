import 'package:flutter/material.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import '../constant/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButton;
  final List<Widget>? action;
  final Color appBarColor;
  final Widget? leadingButton;
  final dynamic data;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
   const CustomAppBar({
    Key? key,
    this.title,
    this.action,this.isBackButton=true,this.appBarColor=appColor, this.bottom, this.toolbarHeight, this.data, this.leadingButton,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight??90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: appBarColor,
      centerTitle: true,
      leading: leadingButton ?? (isBackButton?IconButton(
        onPressed: () {
          locator<NavigationService>().goBack(data: data);
        },
        icon: const Icon(Icons.arrow_back, color: whiteColor),
      ):Container()),
      toolbarHeight: preferredSize.height,
      title:title!=null? Text(title!,style: w_700.copyWith(fontSize: 24)):null,
      actions: action,
      bottom: bottom,
    );
  }
}
