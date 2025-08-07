import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

class Repo {
    static Repo? _instance;
    Repo._();
    factory Repo() => _instance ??= Repo._();
    Future<void> update(LocationData data) async {
        await LocationDao().saveLocation(data);
    }
}

class LocationDao {
  static LocationDao? _instance;

  LocationDao._();

  factory LocationDao() => _instance ??= LocationDao._();

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  Future<void> saveLocation(LocationData data) async {
    await (await prefs).setDouble(latitudePref, data.latitude!);
    await (await prefs).setDouble(longitudePref, data.longitude!);
    await (await prefs).setInt(locationCountPref, await getCount());
  }

  Future<int> getCount() async {
    final prefs = await this.prefs;
    await prefs.reload();
    final count = prefs.getInt(locationCountPref);
    if (count == null) {
      return 0;
    } else {
      return count + 1;
    }
  }
}
