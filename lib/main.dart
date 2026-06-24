import 'package:ai_assistant/controllers/theme_controllar.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/helper/pref.dart';
import 'package:ai_assistant/screen/home_screen.dart';
import 'package:ai_assistant/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await pref.init();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown]);
  final themeController = Get.put(ThemeController());
  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;
  MyApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: const SplashScreen(),
      );
    });
  }
}

extension AppTheme on ThemeData{
  Color get lightTextColor => brightness == Brightness.dark ? Colors.white70 :
  Colors.black54;
  Color get buttonColor => brightness == Brightness.dark ? Colors.cyan.shade500 : Colors.blue;

}