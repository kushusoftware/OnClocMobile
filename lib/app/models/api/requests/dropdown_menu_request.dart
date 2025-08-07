class DropdownMenuRequestFields {
  static const String menuId = 'menuId';

  static const List<String> allFields = [
    menuId
    ];
}

class DropdownMenuRequest {
  final String menuId;

  DropdownMenuRequest({
    required this.menuId,
  });

  factory DropdownMenuRequest.fromJson(Map<String, dynamic> json) => DropdownMenuRequest(
      menuId: (json[DropdownMenuRequestFields.menuId] as String).toString(),
    );

  Map<String, dynamic> toJson() => {
      DropdownMenuRequestFields.menuId: menuId,
    };
}