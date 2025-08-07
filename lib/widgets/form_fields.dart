import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';

Widget onClocCommonTextField(
  ThemeData theme,
  void Function()? onTap,
  String hintText,
  suffixIcon,
  prefixIcon,
  TextInputAction? textInputAction,
  int? maxLines,
  TextEditingController? controller,
  FocusNode? focusNode,
) {
  return TextFormField(
    focusNode: focusNode,
    controller: controller,
    textAlign: TextAlign.left,
    maxLines: maxLines,
    textInputAction: textInputAction,
    onTap: onTap,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: Get.isDarkMode ? onClocDividerColor : onClocHintColorLight,
      ),
      fillColor: Get.isDarkMode ? onClocHintColorLight : onClocWhiteColor,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      suffixIcon:
          suffixIcon == null
              ? Container(width: 0)
              : Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(suffixIcon),
              ),
      suffixIconConstraints: const BoxConstraints(
        minWidth: 10, // Adjust width
        minHeight: 0, // Adjust height
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 10, // Adjust width
        minHeight: 20, // Adjust height
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.all(prefixIcon == null ? 0 : 15.0),
        child:
            prefixIcon == null
                ? const SizedBox(
                  width: 0,
                  height: 0,
                  // color: Colors.yellow,
                )
                : SvgPicture.asset(
                  prefixIcon,
                  colorFilter: ColorFilter.mode(
                    Get.isDarkMode ? onClocWhiteColor : onClocBlueGreyColor,
                    BlendMode.srcIn,
                  ),
                ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: servpalPrimaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

class OutlineBorderTextFormField extends StatefulWidget {
  final FocusNode myFocusNode;
  final TextEditingController tempTextEditingController;
  final String labelText;
  final TextInputType keyboardType;
  final bool autofocus;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final Function validation;
  final bool
  checkOfErrorOnFocusChange; //If true validation is checked when ever focus is changed
  final ThemeData theme;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final bool? isSvg;
  final bool? isIconTrue;
  final bool? obscureText;
  final int? maxLine;
  final bool? isReadOnly;
  final VoidCallback? onTap;

  @override
  State<StatefulWidget> createState() {
    return _OutlineBorderTextFormField();
  }

  const OutlineBorderTextFormField({
    super.key,
    this.suffixIcon,
    this.isIconTrue,
    this.isSvg,
    this.maxLine,
    this.prefixIconColor,
    required this.labelText,
    required this.autofocus,
    required this.tempTextEditingController,
    required this.myFocusNode,
    required this.inputFormatters,
    required this.keyboardType,
    required this.textInputAction,
    required this.validation,
    required this.checkOfErrorOnFocusChange,
    required this.theme,
    this.obscureText,
    this.isReadOnly,
    this.onTap,
  });
}

class _OutlineBorderTextFormField extends State<OutlineBorderTextFormField> {
  bool isError = false;
  bool isFocus = false;
  String errorString = '';

  TextStyle? getLabelTextStyle() {
    return widget.theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w300,
      color: Get.isDarkMode ? onClocWhiteColor : onClocTextColorPrimaryLight,
    );
  }

  TextStyle? getHintTextStyle(bool isFocus) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color:
          isFocus
              ? servpalPrimaryColorLight
              : widget.tempTextEditingController.text.isNotEmpty
              ? servpalPrimaryColorLight
              : onClocGreyColor.withValues(alpha: 0.20),
      fontWeight: FontWeight.w300,
      fontFamily: OnClocTheme.fontFamily,
    );
  }

  TextStyle? getTextFieldStyle() {
    return widget.theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? onClocWhiteColor : onClocTextColorPrimaryLight,
    );
  }

  TextStyle? getErrorTextFieldStyle() {
    return widget.theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w300,
      color: Colors.red,
    );
  }

  Color getBorderColor(bool isFocus) {
    return isFocus
        ? servpalPrimaryColorLight
        : widget.tempTextEditingController.text.isNotEmpty
        ? servpalPrimaryColorLight
        : onClocGreyColor.withValues(alpha: 0.20);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FocusScope(
          child: Focus(
            onFocusChange: (focus) {
              setState(() {
                isFocus = focus;
                getBorderColor(focus);
                if (widget.checkOfErrorOnFocusChange &&
                    widget
                        .validation(widget.tempTextEditingController.text)
                        .toString()
                        .isNotEmpty) {
                  isError = true;

                  errorString = widget.validation(
                    widget.tempTextEditingController.text,
                  );
                } else {
                  isError = false;

                  errorString = widget.validation(
                    widget.tempTextEditingController.text,
                  );
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              decoration: BoxDecoration(
                color: Get.isDarkMode ? servpalBgColorDark : onClocWhiteColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                  color:
                      isError
                          ? Colors.red
                          : getBorderColor(widget.myFocusNode.hasFocus),
                ),
              ),
              child: TextFormField(
                onTap: widget.onTap,
                readOnly: widget.isReadOnly ?? false,
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.start,
                maxLines: widget.maxLine ?? 1,
                obscureText: widget.obscureText ?? false,
                focusNode: widget.myFocusNode,
                onFieldSubmitted: (v) {},
                controller: widget.tempTextEditingController,
                style: getTextFieldStyle(),
                autofocus: widget.autofocus,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                inputFormatters: widget.inputFormatters,
                onChanged: (value) {
                  setState(() {
                    if (widget.validation(value).toString().isNotEmpty) {
                      isError = true;
                      errorString = widget.validation(value);
                    } else {
                      isError = false;
                      errorString = widget.validation(value);
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  labelStyle:
                      isError
                          ? getErrorTextFieldStyle()
                          : getHintTextStyle(isFocus),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  fillColor:
                      Get.isDarkMode ? servpalBgColorDark : onClocWhiteColor,
                  filled: true,
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorStyle: const TextStyle(height: 0),
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  suffixIcon: widget.suffixIcon.validate(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isError ? true : false,
          child: Container(
            padding: const EdgeInsets.only(left: 15.0, top: 2.0),
            child: Text(errorString, style: getErrorTextFieldStyle()),
          ),
        ),
      ],
    );
  }
}
