
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class pref{
  static late Box _box;

  static Future<void> init() async{
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox('myData');
  }

  static bool get showOnboarding => _box.get('showOnboarding', defaultValue: true);
  static set showOnboarding(bool value) => _box.put('showOnboarding', value);

  //for storing theme mode data
  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool value) => _box.put('isDarkMode', value);

  static ThemeMode get defaultTheme{
    final data = _box.get("isDarkMode");
    print("data: $data");
    if(data == null) return ThemeMode.system;
    if(data == true) return ThemeMode.dark;
    return ThemeMode.light;
  }


}