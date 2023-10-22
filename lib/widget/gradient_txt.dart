import 'package:flutter/material.dart';

import '../constant/style.dart';
class GradientTxt extends StatelessWidget {
  final String txt;
  final TextStyle style;
  final TextAlign? textAlign;
  const GradientTxt({Key? key, required this.txt, required this.style,this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>  const LinearGradient(
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
          0.349,
          0.4948,
          0.6563,
          0.776,
          0.8958,
          1.0,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(txt, style: style,textAlign:textAlign ),
    );
  }
}
