import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  const CustomText({
    super.key,
    required this.title,
    required this.size,
    required this.color,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Inter',
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
