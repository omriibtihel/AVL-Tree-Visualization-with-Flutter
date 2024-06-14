import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import './avl_tree.dart';

class CirclePainter extends CustomPainter {
  final AVLTree avlTree;
  final double animationValue;
  CirclePainter(this.avlTree, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    double circleRadius = 25;
    double gap = (size.width) / 4;
    double startX = (size.width) / 2;
    double startY = 30;

    drawNode(canvas, avlTree.root, startX, startY, circleRadius, gap, paint);
  }

  void drawNode(Canvas canvas, Node? node, double x, double y, double radius, double gap, Paint paint) {
    if (node == null) return;

    double animatedRadius = radius * animationValue;
    canvas.drawCircle(Offset(x, y), animatedRadius, paint);

    TextSpan span = TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 20),
      text: node.key.toString(),
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));

    if (node.left != null) {
      double childX = x - gap;
      double childY = y + 100;
      double angle = atan2(childY - y, childX - x);
      double X1 = x + animatedRadius * cos(angle);
      double Y1 = y + animatedRadius * sin(angle);
      double X2 = childX - animatedRadius * cos(angle);
      double Y2 = childY - animatedRadius * sin(angle);

      drawNode(canvas, node.left, childX, childY, radius, gap / 2, paint);
      canvas.drawLine(Offset(X1, Y1), Offset(X2, Y2), paint);
    }

    if (node.right != null) {
      double childX = x + gap;
      double childY = y + 100;
      double angle = atan2(childY - y, childX - x);
      double X1 = x + animatedRadius * cos(angle);
      double Y1 = y + animatedRadius * sin(angle);
      double X2 = childX - animatedRadius * cos(angle);
      double Y2 = childY - animatedRadius * sin(angle);

      drawNode(canvas, node.right, childX, childY, radius, gap / 2, paint);
      canvas.drawLine(Offset(X1, Y1), Offset(X2, Y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
