// import 'dart:async' show Future;
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class StorageUtil {
//   static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
//   static SharedPreferences _prefsInstance;
//
//   // call this method from iniState() function of mainApp().
//   static Future<SharedPreferences> init() async {
//     _prefsInstance = await _instance;
//     return _prefsInstance;
//   }
//
//
//   static String getString(String key, [String defValue]) {
//     return _prefsInstance.getString(key) ?? defValue ?? "";
//   }
//
//   static Future<bool> setString(String key, String value) async {
//     var prefs = await _instance;
//     return prefs?.setString(key, value) ?? Future.value(false);
//   }
//
//   static int getInt(String key, [String defValue]) {
//     return _prefsInstance.getInt(key) ?? defValue ?? "";
//   }
//
//   static Future<bool> setInt(String key, int value) async {
//     var prefs = await _instance;
//     return prefs?.setInt(key, value) ?? Future.value(false);
//   }
//   static double getDouble(String key, [double defValue]) {
//     return _prefsInstance.getDouble(key) ?? defValue ?? "";
//   }
//
//   static Future<bool> setDouble(String key, double value) async {
//     var prefs = await _instance;
//     return prefs?.setDouble(key, value) ?? Future.value(false);
//   }
//
//   static Future<bool> setList(String key,List<String> value) async{
//     var prefs = await _instance;
//     return prefs?.setStringList(key, value) ?? Future.value(false);
//   }
//
//   static List<String> getList(String key, [List<String> defValue]) {
//     return _prefsInstance.getStringList(key) ?? defValue ?? "";
//   }
//
//
// }