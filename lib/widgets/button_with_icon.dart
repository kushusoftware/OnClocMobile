import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';

class OnClocButtonWithIcon extends StatelessWidget {
    final VoidCallback onPressed;
  final String text;
  final String iconName;
  final double? width;
  final double? borderRadius;
  final double? height;
  final double? fontSize;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  final BoxBorder? boxBorder;
  final TextStyle? textStyle;
  final ColorFilter? filter;

  const OnClocButtonWithIcon({
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
    this.textStyle, required this.iconName, this.filter, this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 55.0,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius ?? 50.0),
          color: bgColor ?? servpalPrimaryColor),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ??50.0),
            // side: BorderSide(color:borderColor ?? Colors.transparent,width: 1 )
          ),
          elevation: 4,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconName,width: 20,height: 20,colorFilter: filter,),
            10.width,
            Text(
              text,
              style: textStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: textColor ?? Colors.white,
                      fontFamily: OnClocTheme.fontFamily),
            ),
          ],
        ),
      ),
    );
  }

}