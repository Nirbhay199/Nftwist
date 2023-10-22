import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color.dart';

class Button extends StatelessWidget {
  final String buttonTxt;
  final double radius;
  final Color? txtColor;
  final dynamic function;
  final double verticalPadding;
  final double? horizontalPadding;
  final Widget? icon;

  final Color? color;
  final bool active;
  const Button({
    Key? key,
    required this.buttonTxt,
    required this.function,
    this.radius = 8,
    this.verticalPadding = 0,
    this.color,
    this.icon,
    this.txtColor,
    this.horizontalPadding,this.active=true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding ?? 0),
      child: GestureDetector(
        onTap:!active?null: function,
        child: Container(
          height: 52,
            constraints: const BoxConstraints(minWidth: 128),
            margin:const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            gradient: const LinearGradient(
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

              ),
              child:Stack(
                fit: StackFit.expand,
                children: [
                  if(!active)    Container(
                color: Colors.black54,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  if (icon != null)
                    const SizedBox(
                      width: 10,
                    ),
                  Text(
                    buttonTxt,
                    style:  TextStyle(
                        color: txtColor ?? textColor,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        fontSize: 16,
                        letterSpacing: .5,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
class Button_2 extends StatelessWidget {
  final String buttonTxt;
  final double radius;
  final Color? txtColor;
  final bool? normalBorder;
  final dynamic function;
  final double verticalPadding;
  final double? horizontalPadding;
  final double? minHeight;
  final Widget? icon;
  final Color? color;
  const Button_2({
    Key? key,
    this.normalBorder,
    required this.buttonTxt,
    required this.function,
    this.radius = 56,
    this.verticalPadding = 0,
    this.color,
    this.icon,
    this.txtColor,
    this.horizontalPadding,
    this.minHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding ?? 0),
      child: UnicornOutlineButton(
        strokeWidth: 2,
        radius: radius,minHeight:minHeight ,
        gradient: normalBorder==true?const LinearGradient(colors: [whiteColor2,Colors.white]): const LinearGradient(
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
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null)
              const SizedBox(
                width: 10,
              ),
            Text(
              buttonTxt,
              style: TextStyle(
                  color: txtColor ?? textColor,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontSize: 16,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;
 final double? minWidth;
 final double? minHeight;
  UnicornOutlineButton({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed, this.minWidth, this.minHeight,
  })  : this._painter = _GradientPainter(strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: BoxConstraints(minWidth: minWidth??MediaQuery.of(context).size.width, minHeight: minHeight??52),
            child: _child,
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({required double strokeWidth, required double radius, required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}