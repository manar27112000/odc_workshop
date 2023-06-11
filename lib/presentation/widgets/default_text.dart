import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:workshop/presentation/styles/app_colors.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({Key? key, required this.text, this.textColor, this.fontSize, this.maxLines}) : super(key: key);
final String text;
final Color? textColor;
final double? fontSize;
final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}
