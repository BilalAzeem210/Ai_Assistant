import 'package:ai_assistant/helper/pref.dart';
import 'package:ai_assistant/screen/home_screen.dart';
import 'package:ai_assistant/screen/onboarding_screen.dart';
import 'package:ai_assistant/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../helper/global.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("SHOW ONBOARDING: ${pref.showOnboarding}");
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final nextScreen = pref.showOnboarding
          ? const OnboardingScreen()
          : const HomeScreen();

      Get.offAll(() => nextScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.all(mq.width * 0.05),
                child: Image.asset("assets/images/appicon.png", width: mq.width * .4,),),
            ),
          ),
          SizedBox(height: mq.height * 0.2),
          CustomLoading(),
          Spacer(),
        ],
      ),


    );
  }
}
