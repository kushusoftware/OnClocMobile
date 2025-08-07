import 'package:flutter/material.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';

class OnClocCommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  final BoxBorder? boxBorder;
  final TextStyle? textStyle;

  const OnClocCommonButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.fontSize,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.boxBorder,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 56.0,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
          color: bgColor ?? servpalPrimaryColorLight),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            // side: BorderSide(color:borderColor ?? Colors.transparent,width: 1 )
          ),
          elevation: 4,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle ??
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: textColor ?? Colors.white,
                  fontFamily: OnClocTheme.fontFamily),
        ),
      ),
    );
  }
}