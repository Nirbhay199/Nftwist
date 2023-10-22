import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';

class TextFieldForm extends StatefulWidget {
  final String hintText;
  final bool isLeading;
  final bool isCountry;
  final Widget? leading;
  final TextEditingController? tfController;
  final Function? validator2;
  final IconButton? postfix;
  final List<TextInputFormatter>?  filterPattern;
  final TextInputType? keyboardType;
  final bool isPass;
  final bool? readOnly;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final int? maxLines;
  final int? minLines;
  final String? kImage;
  final double? topPadding;
  final double? bottomPadding;
  final double? horizontalPadding;
  final double? borderRadius;
  final String? initialValue;
  final Function? onChange;
  final void Function()? onTap;
  final Function? onFieldSubmitted;
  const TextFieldForm({
    Key? key,
    required this.hintText,
    this.tfController,
    this.focusNode,
    this.postfix,
    this.onTap,
    this.validator2,
    this.keyboardType,
    this.isPass = false,
    this.minLines,
    this.maxLines,
    this.kImage,
    this.initialValue,
    this.readOnly,
    this.onChange,
    this.filterPattern,
    this.onFieldSubmitted,
    this.topPadding,
    this.bottomPadding,
    this.horizontalPadding,
    this.borderRadius,
    this.autofillHints,
    this.isLeading=false,
    this.isCountry=false,
    this.leading,
  }) : super(key: key);

  @override
  State<TextFieldForm> createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  bool showPass = true;
  String countryCode = "971";
  String countryName = "";
  var flag = '🇦🇪';
  int length = 9;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius??38),
          border: Border.all(width: 2, color: const Color(0xffE6E6E6))
      ),
      margin: EdgeInsets.only(
          top: widget.topPadding ?? 0,
          bottom: widget.bottomPadding ?? 0,
          left: widget.horizontalPadding ?? 20,
          right: widget.horizontalPadding ?? 20),
      // padding: EdgeInsets.only(left: 0,),
      child: Row(
        children: [
          if(widget.isLeading==true||widget.isCountry)const SizedBox(width: 18,),
          if((widget.isLeading==true||widget.isCountry)&&widget.leading!=null) widget.leading!,
           const SizedBox(
            width: 10,
          ),
          if(widget.isCountry==false&&widget.isLeading)const SizedBox(
    height: 30,
    child: VerticalDivider(
    width: 8,
    thickness: 2,
    )),
          Expanded(
            child: TextFormField(
              cursorColor: Colors.white60,
              cursorHeight: 20,
              focusNode: widget.focusNode,
              cursorWidth: 1.5,
              onTap: (){
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                if(widget.onTap!=null)widget.onTap!();
              },
              controller: widget.tfController,
              initialValue: widget.initialValue,
              autofillHints: widget.autofillHints,
              readOnly: widget.readOnly == null ? false : widget.readOnly!,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.filterPattern ?? null,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: widget.isPass == true ? showPass : false,
              maxLines: widget.maxLines ?? 1,
              minLines: widget.minLines ?? 1,
              validator: (value) {
                if (widget.validator2 != null) {
                  return widget.validator2!(value);
                }
                return null;
              },
              onChanged: (string) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                if (widget.onChange != null) {
                  widget.onChange!(string);
                }
              },
              onFieldSubmitted: (string) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                if (widget.onFieldSubmitted != null) {
                  widget.onFieldSubmitted!(string);
                }
              },
              style: TextStyle(
                fontFamily: widget.isPass == false && !showPass ? GoogleFonts.montserrat().fontFamily : '',
                color: textFieldColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: .5,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,

                /*OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: borderColor, width: .5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: borderColor, width: .5)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: borderColor, width: .5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: borderColor, width: .5)),*/
                prefixIcon: widget.kImage != null
                    ? Container(
                  // height: 16,
                    padding: const EdgeInsets.fromLTRB(14,14,14,12),
                    child: SvgPicture.asset(widget.kImage!,))

                    : null,
                contentPadding: const EdgeInsets.fromLTRB(14,16,14,12),
                hintText: widget.hintText,
                hintStyle:  TextStyle(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  color: textFieldColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .5,
                ),
                suffixIcon: widget.isPass == true
                    ? IconButton(
                  // padding:const EdgeInsets.symmetric(vertical: 18.5,horizontal: 17),
                  onPressed: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                  icon: !showPass?
                      const Icon(Icons.visibility_outlined,color: whiteColor,):
                      const Icon(Icons.visibility_off_outlined,color: whiteColor,),
                      // ? SvgPicture.asset("assets/icons/eye_on.svg")
                      // : SvgPicture.asset("assets/icons/eye_off.svg"),
                  color: const Color(0xff7B888B),
                )
                    : widget.postfix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
