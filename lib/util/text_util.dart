import 'package:flutter/material.dart';

class TextUtil extends StatelessWidget {
  String text;
  Color? color;
  double? size;
  bool? weight;
  TextAlign? align;

  TextUtil({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
          color: color,
          fontSize: size ?? 16,
          fontWeight: weight == null ? FontWeight.w600 : FontWeight.w500),
    );
  }
}
