import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:shimmer/shimmer.dart';

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() => Image.asset(onClocPlaceholder, fit: BoxFit.cover);

Widget buildShimmer(double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[400]!.withValues(alpha: 0.3),
      highlightColor: Colors.grey[100]!.withValues(alpha: 0.5),
      child: Card(
        shape: buildRoundedCorner(),
        color: Colors.white,
      ),
    ),
  );
}

RoundedRectangleBorder buildRoundedCorner({double? radius}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? 10));
}

RoundedRectangleBorder buildCardCorner({double? radius}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? 16));
}

RoundedRectangleBorder buildButtonCorner({double? radius}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? 32));
}

Widget inputTitleText(String title, ThemeData theme) {
  return Text(
    title,
    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
  );
}

InputDecoration onClocInputDecoration(
  BuildContext context, {
  String? prefixIcon,
  String? suffixIcon,
  String? labelText,
  double? borderRadius,
  String? hintText,
  bool? isSvg,
  Color? fillColor,
  Color? borderColor,
  Color? focusBorderColor,
  Color? hintColor,
  Color? prefixIconColor,
  double? leftContentPadding,
  double? rightContentPadding,
  double? topContentPadding,
  double? bottomContentPadding,
  double? borderWidth,
  double? suffixRightPadding,
  VoidCallback? onSuffixPressed,
}) {
  return InputDecoration(
    counterText: '',
    contentPadding: EdgeInsets.fromLTRB(
      leftContentPadding ?? 20,
      topContentPadding ?? 20,
      rightContentPadding ?? 20,
      bottomContentPadding ?? 20,
    ),
    labelText: labelText,
    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: hintColor ?? servpalTextColorLight.withValues(alpha: 0.20),
      fontWeight: FontWeight.w400,
      fontFamily: OnClocTheme.fontFamily,
    ),
    alignLabelWithHint: true,
    hintText: hintText.validate(),
    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: hintColor ?? servpalTextColorLight.withValues(alpha: 0.20),
      fontWeight: FontWeight.w400,
      fontFamily: OnClocTheme.fontFamily,
    ),
    isDense: true,
    prefixIcon:
        prefixIcon != null
            ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child:
                  isSvg == null
                      ? SvgPicture.asset(
                        prefixIcon,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          prefixIconColor ?? servpalTextColorLight,
                          BlendMode.srcIn,
                        ),
                      )
                      : Image.asset(prefixIcon, width: 24, height: 24),
            )
            : null,
    prefixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
    suffixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
    suffixIcon:
        suffixIcon != null
            ? InkWell(
              onTap: onSuffixPressed ?? () {},
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: suffixRightPadding ?? 10,
                ),
                child:
                    isSvg == null
                        ? SvgPicture.asset(
                          suffixIcon,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            prefixIconColor ?? servpalTextColorLight,
                            BlendMode.srcIn,
                          ),
                        )
                        : Image.asset(suffixIcon, width: 24, height: 24),
              ),
            )
            : null,
    border: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(
        color: borderColor ?? onClocGreyColor.withValues(alpha: 0.20),
        width: borderWidth ?? 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(
        color: borderColor ?? onClocGreyColor.withValues(alpha: 0.20),
        width: borderWidth ?? 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(
        color: focusBorderColor ?? servpalPrimaryColor,
        width: borderWidth ?? 1.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: borderWidth ?? 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: borderWidth ?? 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(
      color: Colors.red,
      size: 12,
      fontFamily: OnClocTheme.fontFamily,
    ),
    filled: true,
    fillColor: fillColor ?? Colors.white,
  );
}

PreferredSizeWidget onClocCommonAppBarWidget(
  BuildContext context, {
  String? titleText,
  Widget? actionWidget,
  Widget? actionWidget2,
  Widget? actionWidget3,
  Widget? leadingWidget,
  Color? backgroundColor,
  double? leadingWidth,
  bool? isTitleCenter,
  bool isback = true,
}) {
  Color bgColor = Get.isDarkMode ? servpalBgColorDark : servpalBgColorLight;
  return AppBar(
    centerTitle: isTitleCenter ?? true,
    backgroundColor: backgroundColor ?? bgColor,
    leadingWidth: leadingWidth,
    leading:
        isback
            ? IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                onClocCaretLeftIcon,
                colorFilter: ColorFilter.mode(
                  Get.isDarkMode
                      ? servpalTextColorDark
                      : servpalTextColorLight,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
            : leadingWidget,
    actions: [
      actionWidget ?? const SizedBox(),
      actionWidget2 ?? const SizedBox(),
      actionWidget3 ?? const SizedBox(),
    ],
    title: Text(
      titleText ?? '',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontFamily: OnClocTheme.fontFamily,
        fontSize: 16,
      ),
    ),
    elevation: 0.0,
  );
}

Widget onClocPortalCachedImageWidget(
  String url,
  double height, {
  double? width,
  BoxFit? fit,
  Color? color,
}) {
  String imageUrl = '$basePortalUrl$url';
  if (imageUrl.validate().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        placeholder:
            placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: imageUrl,
        height: height,
        width: width,
        color: color,
        fit: fit ?? BoxFit.cover,
        errorWidget: (_, _, _) {
          return SizedBox(height: height, width: width);
        },
      );
    } else {
      return Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
    }
  } else {
    return Image.asset(
      imageUrl,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
    );
  }
}

extension Ext on BuildContext {
  ThemeData get theme => Theme.of(this);

  double get w => MediaQuery.of(this).size.width;

  double get h => MediaQuery.of(this).size.height;
}

Widget onClocCommonListViewItemWidget(
  String iconName, 
  String data,
  bool isDarkModeOn, 
  ThemeData theme,
  VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: onClocGreyColor.withValues(alpha: 0.10),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconName,
          width: 15,
          height: 15,
          colorFilter: ColorFilter.mode(
            isDarkModeOn ? servpalTextColorDark : servpalTextColorLight,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        data,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isDarkModeOn ? servpalTextColorDark : servpalTextColorLight,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: SvgPicture.asset(
        onClocCaretRightIcon,
        width: 15,
        height: 15,
        colorFilter: ColorFilter.mode(
          isDarkModeOn ? servpalTextColorDark : servpalTextColorLight,
          BlendMode.srcIn,
        ),
      ),
    );
  }

Widget loadingWidgetMaker() {
  return Container(
    alignment: Alignment.center,
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: servpalPrimaryColor,
        ),
      ),
    ),
  );
}

InputDecoration newEditTextDecoration(IconData icon, String title,
    {String? hint,
    Color? bgColor,
    Color? borderColor,
    EdgeInsets? padding,
    String? errorText}) {
  return InputDecoration(
    contentPadding:
        padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    counter: const Offstage(),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor ?? servpalPrimaryColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.4)),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.red),
    ),
    fillColor: bgColor ?? servpalPrimaryColor.withValues(alpha: 0.04),
    hintText: hint,
    errorText: errorText,
    labelText: title,
    prefixIcon: Icon(icon, color: servpalPrimaryColor),
    hintStyle: secondaryTextStyle(),
    filled: true,
  );
}

InputDecoration newEditTextNoIconDecoration(String title,
    {String? hint,
    Color? bgColor,
    Color? borderColor,
    EdgeInsets? padding,
    String? errorText}) {
  return InputDecoration(
    contentPadding:
        padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    counter: const Offstage(),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor ?? servpalPrimaryColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.4)),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.red),
    ),
    fillColor: bgColor ?? servpalPrimaryColor.withValues(alpha: 0.04),
    hintText: hint,
    errorText: errorText,
    labelText: title,
    hintStyle: secondaryTextStyle(),
    filled: true,
  );
    }