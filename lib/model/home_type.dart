import 'package:ai_assistant/screen/feature/aiimagegenerator_feature.dart';
import 'package:ai_assistant/screen/feature/ailanguagetranslator_feature.dart';
import 'package:ai_assistant/screen/feature/chatbot_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

enum HomeType {ChatBot, ImageGenerator, LanguageTranslator}

extension MyHomeType on HomeType{

  String get title => switch (this){

    HomeType.ChatBot => 'ChatBot',
    HomeType.ImageGenerator => 'Image Creator',
    HomeType.LanguageTranslator => 'Language Translator',

  };

  String get lottie => switch (this){

    HomeType.ChatBot => 'ai_hand_waving.json',
    HomeType.ImageGenerator => 'ai_play.json',
    HomeType.LanguageTranslator => 'ai_ask_me.json',

  };


  bool get leftAlign => switch (this){

    HomeType.ChatBot => true,
    HomeType.ImageGenerator => false,
    HomeType.LanguageTranslator => true,

  };

  EdgeInsets get Padding => switch (this){

    HomeType.ChatBot => EdgeInsets.zero,
    HomeType.ImageGenerator => EdgeInsets.all(26),
    HomeType.LanguageTranslator => EdgeInsets.zero,

  };

  VoidCallback get onTap => switch (this){
    HomeType.ChatBot => () => Get.to(() => ChatbotFeature()),
    HomeType.ImageGenerator => () => Get.to(() => AiimagegeneratorFeature()),
    HomeType.LanguageTranslator => () => Get.to(() => AilanguagetranslatorFeature()),
  };
}