import 'package:flutter/material.dart';

class CustomCardFor extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double elevation;
  final Gradient? gradient;

  const CustomCardFor({
    required this.child,
    this.color,
    this.elevation = 2.0,
    this.gradient,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: elevation,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient ?? LinearGradient(colors: [color!, color!]),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: child,
      ),
    );
  }
}
