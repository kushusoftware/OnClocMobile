class DeviceIdentityFields{
  static const String uuid = 'uuid';
  static const String name = 'name';
  static const String type = 'type';
  static const String manufacturer = 'manufacturer';
  static const String product = 'product';
  static const String brand = 'brand';
  static const String model = 'model';
  static const String board = 'board';
  static const String version = 'version';
  static const String serialNumber = 'serialNumber';
  static const String sdkVersion = 'sdkVersion';
  static const String osName = 'os';
  static const String osVersion = 'osVersion';

  static const List<String> allFields = [
    uuid,
    name,
    type,
    manufacturer,
    product,
    brand,
    model,
    board,
    version,
    serialNumber,
    sdkVersion,
    osName,
    osVersion,
  ];
}

class DeviceIdentity{
  String? uuid;
  String? name;
  String? type;
  String? manufacturer;
  String? product;
  String? brand;
  String? model;
  String? board;
  String? version;
  String? serialNumber;
  String? sdkVersion;
  String? osName;
  String? osVersion;

  DeviceIdentity({
    this.uuid,
    this.name,
    this.type,
    this.manufacturer,
    this.product,
    this.brand,
    this.model,
    this.board,
    this.version,
    this.serialNumber,
    this.sdkVersion,
    this.osName,
    this.osVersion,
  });

  factory DeviceIdentity.fromJson(Map<String, dynamic> json) {
    return DeviceIdentity(
      uuid: json[DeviceIdentityFields.uuid] as String?,
      name: json[DeviceIdentityFields.name] as String?,
      type: json[DeviceIdentityFields.type] as String?,
      manufacturer: json[DeviceIdentityFields.manufacturer] as String?,
      product: json[DeviceIdentityFields.product] as String?,
      brand: json[DeviceIdentityFields.brand] as String?,
      model: json[DeviceIdentityFields.model] as String?,
      board: json[DeviceIdentityFields.board] as String?,
      version: json[DeviceIdentityFields.version] as String?,
      serialNumber: json[DeviceIdentityFields.serialNumber] as String?,
      sdkVersion: json[DeviceIdentityFields.sdkVersion] as String?,
      osName: json[DeviceIdentityFields.osName] as String?,
      osVersion: json[DeviceIdentityFields.osVersion] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      DeviceIdentityFields.uuid: uuid,
      DeviceIdentityFields.name: name,
      DeviceIdentityFields.type: type,
      DeviceIdentityFields.manufacturer: manufacturer,
      DeviceIdentityFields.product: product,
      DeviceIdentityFields.brand: brand,
      DeviceIdentityFields.model: model,
      DeviceIdentityFields.board: board,
      DeviceIdentityFields.version: version,
      DeviceIdentityFields.serialNumber: serialNumber,
      DeviceIdentityFields.sdkVersion: sdkVersion,
      DeviceIdentityFields.osName: osName,
      DeviceIdentityFields.osVersion: osVersion,
    };
  }
}