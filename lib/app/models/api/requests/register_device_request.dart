class RegisterDeviceRequestFields {
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
  static const String osName = 'osName';
  static const String osVersion = 'osVersion';
  static const String batteryPercentage = 'batteryPercentage';
  static const String isGpsEnabled = 'isGpsEnabled';
  static const String isWifiEnabled = 'isWifiEnabled';
  static const String signalStrength = 'signalStrength';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';

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
    batteryPercentage,
    isGpsEnabled,
    isWifiEnabled,
    signalStrength,
    latitude,
    longitude
  ];
}

class RegisterDeviceRequest {
  final String? uuid;
  final String? name;
  final String? type;
  final String? manufacturer;
  final String? product;
  final String? brand;
  final String? model;
  final String? board;
  final String? version;
  final String? serialNumber;
  final String? sdkVersion;
  final String? osName;
  final String? osVersion;
  final int? batteryPercentage;
  final int? signalStrength;
  final bool? isGpsEnabled;
  final bool? isWifiEnabled;
  final double? latitude;
  final double? longitude;

  RegisterDeviceRequest({
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
    this.batteryPercentage,
    this.signalStrength,
    this.isGpsEnabled,
    this.isWifiEnabled,
    this.latitude,
    this.longitude
  });

  factory RegisterDeviceRequest.fromJson(Map<String, dynamic> json) => 
  RegisterDeviceRequest(
      uuid: json[RegisterDeviceRequestFields.uuid],
      name: json[RegisterDeviceRequestFields.name],
      type: json[RegisterDeviceRequestFields.type],
      manufacturer: json[RegisterDeviceRequestFields.manufacturer],
      product: json[RegisterDeviceRequestFields.product],
      brand: json[RegisterDeviceRequestFields.brand],
      model: json[RegisterDeviceRequestFields.model],
      board: json[RegisterDeviceRequestFields.board],
      version: json[RegisterDeviceRequestFields.version],
      serialNumber: json[RegisterDeviceRequestFields.serialNumber],
      sdkVersion: json[RegisterDeviceRequestFields.sdkVersion],
      osName: json[RegisterDeviceRequestFields.osName],
      osVersion: json[RegisterDeviceRequestFields.osVersion],
      batteryPercentage: json[RegisterDeviceRequestFields.batteryPercentage],
      isGpsEnabled: json[RegisterDeviceRequestFields.isGpsEnabled],
      isWifiEnabled: json[RegisterDeviceRequestFields.isWifiEnabled],
      signalStrength: json[RegisterDeviceRequestFields.signalStrength],
      latitude: json[RegisterDeviceRequestFields.latitude],
      longitude: json[RegisterDeviceRequestFields.longitude],
    );
  
  Map<String, dynamic> toJson() => {
        RegisterDeviceRequestFields.uuid: uuid,
        RegisterDeviceRequestFields.name: name,
        RegisterDeviceRequestFields.type: type,
        RegisterDeviceRequestFields.manufacturer: manufacturer,
        RegisterDeviceRequestFields.product: product,
        RegisterDeviceRequestFields.brand: brand,
        RegisterDeviceRequestFields.model: model,
        RegisterDeviceRequestFields.board: board,
        RegisterDeviceRequestFields.version: version,
        RegisterDeviceRequestFields.serialNumber: serialNumber,
        RegisterDeviceRequestFields.sdkVersion: sdkVersion,
        RegisterDeviceRequestFields.osName: osName,
        RegisterDeviceRequestFields.osVersion: osVersion,
        RegisterDeviceRequestFields.batteryPercentage: batteryPercentage,
        RegisterDeviceRequestFields.isGpsEnabled: isGpsEnabled,
        RegisterDeviceRequestFields.isWifiEnabled: isWifiEnabled,
        RegisterDeviceRequestFields.signalStrength: signalStrength,
        RegisterDeviceRequestFields.latitude: latitude,
        RegisterDeviceRequestFields.longitude: longitude
  };    
}
