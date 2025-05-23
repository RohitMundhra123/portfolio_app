import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String stopWatchTime = 'stopWatchTime';
  static const String stopWatchLaps = 'stopWatchLaps';
  static const String alarms = 'alarms';

  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    if (_prefs != null) {
      return;
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }

  bool? containsKey(String key) {
    return _prefs?.containsKey(key);
  }

  Set<String>? getKeys() {
    return _prefs?.getKeys();
  }
}
