import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  const OtpField({
    Key? key, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 26.0,horizontal: 31),
      child: SizedBox(height: 60,
        child: PinInputTextField(
          controller: controller,
          // codeLength: 4,
          // currentCode: _code,
          pinLength: 4,
          decoration: BoxLooseDecoration(
            // lineHeight: 1,
            bgColorBuilder: PinListenColorBuilder(
              blackColor, // Set your desired color for the underline
              blackColor,
            ),
            strokeColorBuilder: const FixedColorBuilder(Color(0xffF1F2F2)),
            radius: const Radius.circular(9),
          ),
          onChanged: (code) {},
          cursor: Cursor(
            width: 1,
            height: 30,
            color: whiteColor,
            radius: const Radius.circular(1),
            enabled: true,
          ),
        ),
      ),
    );
  }
}
