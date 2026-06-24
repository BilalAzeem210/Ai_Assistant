import 'package:ai_assistant/apis/apis.dart';
import 'package:ai_assistant/helper/my_dailog.dart';
import 'package:ai_assistant/model/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

  final textC = TextEditingController();
  final scrollController = ScrollController();

  final list = <Message>[
    Message(msg: 'Hello, Welcome to Ai ChatBot', type: MessageType.bot),
  ].obs;

  void askQuestion() async{
    if(textC.text.trim().isNotEmpty){
      //user
      list.add(Message(msg: textC.text, type: MessageType.user));
      list.add(Message(msg: '', type: MessageType.bot));
      _scrollDown();
      final res = await Apis().getAnswer(textC.text);

      list.removeLast();
      //ai bot
      list.add(Message(msg: res, type: MessageType.bot));
      _scrollDown();
      textC.text = '';
      
      
      
    }
    else{
      MyDailog.info("Please Type Something");
    }
    
  }

  void _scrollDown(){
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );

  }

}