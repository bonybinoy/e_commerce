import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final String? fontFamily;
  final FontWeight? weight;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final TextAlign? align;
  final int? line;

  const TextWidget(
      {super.key,
      required this.text,
      this.color,
      this.size,
      this.fontFamily,
      this.weight,
      this.decoration,
      this.overflow,
      this.align,
      this.line});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: line,
      style: TextStyle(
          fontFamily: fontFamily,
          decoration: decoration,
          overflow: overflow,
          fontSize: size,
          color: color,
          fontWeight: weight),
      textAlign: align,
    );
  }
}
