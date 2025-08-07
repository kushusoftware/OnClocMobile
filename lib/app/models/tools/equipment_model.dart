const  String onClocEquipmentTable = 'equipment';

class EquipmentFields {
  static const String id = 'id';
  static const String equipmentId = 'equipment_id';
  static const String customerProfileId= 'customer_profile_id';
  static const String equipmentBrand = 'equipment_brand';
  static const String equipmentFamily = 'equipment_family';
  static const String equipmentCategory = 'equipment_category';
  static const String equipmentGroup = 'equipment_group';
  static const String equipmentOwnership = 'equipment_ownership';
  static const String code = 'code';
  static const String name = 'name';
  static const String description = 'description';
  static const String model = 'model';
  static const String partNumber = 'part_number';
  static const String serialNumber = 'serial_number';
  static const String count = 'count';

  static const List<String> allFields = [
    id,
    equipmentId,
    customerProfileId,
    equipmentBrand,
    equipmentFamily,
    equipmentCategory,
    equipmentGroup,
    equipmentOwnership,
    code,
    name,
    description,
    model,
    partNumber,
    serialNumber,
    count
  ];
}

class OnClocEquipment {
  final int id;
  final String equipmentId;
  final String? customerProfileId;
  final String equipmentBrand;
  final String equipmentFamily;
  final String equipmentCategory;
  final String equipmentGroup;
  final String equipmentOwnership;
  final String code;
  final String name;
  final String description;
  final String? model;
  final String? partNumber;
  final String? serialNumber;
  final int count;

  const OnClocEquipment({
    required this.id,
    required this.equipmentId,
    this.customerProfileId,
    required this.equipmentBrand,
    required this.equipmentFamily,
    required this.equipmentCategory,
    required this.equipmentGroup,
    required this.equipmentOwnership,
    required this.code,
    required this.name,
    required this.description,
    this.model,
    this.partNumber,
    this.serialNumber,
    required this.count,
  });

  factory OnClocEquipment.fromJson(Map<String, dynamic> json) {
    return OnClocEquipment(
      id: json[EquipmentFields.id] as int,
      equipmentId: json[EquipmentFields.equipmentId] as String,
      customerProfileId: json[EquipmentFields.customerProfileId] as String?,
      equipmentBrand: json[EquipmentFields.equipmentBrand] as String,
      equipmentFamily: json[EquipmentFields.equipmentFamily] as String,
      equipmentCategory: json[EquipmentFields.equipmentCategory] as String,
      equipmentGroup: json[EquipmentFields.equipmentGroup] as String,
      equipmentOwnership: json[EquipmentFields.equipmentOwnership] as String,
      code: json[EquipmentFields.code] as String,
      name: json[EquipmentFields.name] as String,
      description: json[EquipmentFields.description] as String,
      model: json[EquipmentFields.model] as String?,
      partNumber: json[EquipmentFields.partNumber] as String?,
      serialNumber: json[EquipmentFields.serialNumber] as String?,
      count: (json[EquipmentFields.count] as num).toInt(),
    );
  }
  
  Map<String, dynamic> toJson() => {
        EquipmentFields.id: id,
        EquipmentFields.equipmentId: equipmentId,
        EquipmentFields.customerProfileId: customerProfileId,
        EquipmentFields.equipmentBrand: equipmentBrand,
        EquipmentFields.equipmentFamily: equipmentFamily,
        EquipmentFields.equipmentCategory: equipmentCategory,
        EquipmentFields.equipmentGroup: equipmentGroup,
        EquipmentFields.equipmentOwnership: equipmentOwnership,
        EquipmentFields.code: code,
        EquipmentFields.name: name,
        EquipmentFields.description: description,
        EquipmentFields.model: model,
        EquipmentFields.partNumber: partNumber,
        EquipmentFields.serialNumber: serialNumber,
        EquipmentFields.count: count,
      };
}