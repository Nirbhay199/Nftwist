import 'package:flutter/cupertino.dart';
import 'package:nftwist/constant/color.dart';

class RoundedTabIndicator extends Decoration {
  RoundedTabIndicator({
    Color color = whiteColor,
    double radius = 2.0,
    double width = 20.0,
    double height = 4.0,
    double bottomMargin = 50.0,
  }) : _painter = _RoundedRectanglePainter(
    color,
    width,
    height,
    radius,
    bottomMargin,
  );
  final BoxPainter _painter;
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _RoundedRectanglePainter extends BoxPainter {
  _RoundedRectanglePainter(
      Color color,
      this.width,
      this.height,
      this.radius,
      this.bottomMargin,
      ) : _paint = Paint()
    ..color = color
    ..isAntiAlias = true;
  final Paint _paint;
  final double radius;
  final double width;
  final double height;
  final double bottomMargin;
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final centerX = cfg.size!.width / 2 + offset.dx;
    final bottom = cfg.size!.height - bottomMargin;
    final halfWidth = width / 2;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTRB(
          centerX - halfWidth,
          bottom - height,
          centerX + halfWidth,
          bottom,
        ),
        bottomRight: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),topLeft:  Radius.circular(radius),
        topRight:Radius.circular(radius),
      ),
      _paint,
    );
  }
}
