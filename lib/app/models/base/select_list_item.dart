import 'package:get/get.dart';

class SelectListItemFields {
  static const String value = 'value';
  static const String text = 'text';
  static const String type = 'data';
  static const String isSelected = 'isSelected';

  static const List<String> allFields = [
    text,
    value,
    type,
    isSelected,
  ];
}

class SelectListItem<T> {
  final dynamic value;
  final String text;
  final T type;
  final RxBool isSelected;

  SelectListItem(
    this.value,
    this.text, 
    this.type,
    {bool isSelected = false})
      : isSelected = isSelected.obs;

  @override
  String toString() {
    return 'SelectListItem{${SelectListItemFields.value}: $value, ${SelectListItemFields.text}: $text, ${SelectListItemFields.isSelected}: $isSelected}';
  }

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is SelectListItem &&
        other.value == value &&
        other.text == text &&
        other.isSelected.value == isSelected.value;
  }

  @override
  int get hashCode => value.hashCode ^ text.hashCode ^ isSelected.hashCode;
}