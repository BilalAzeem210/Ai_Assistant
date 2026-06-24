import 'package:ai_assistant/controllers/chat_controller.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotFeature extends StatefulWidget {
  const ChatbotFeature({super.key});

  @override
  State<ChatbotFeature> createState() => _ChatbotFeatureState();
}

class _ChatbotFeatureState extends State<ChatbotFeature> {
  final _chatController = ChatController();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat With Ai Assistant"),
      ),

      body: Obx(
           () => ListView(

             controller: _chatController.scrollController,
             physics: BouncingScrollPhysics(),
             padding: EdgeInsets.only(top:mq.height * .02,bottom: mq.height * .12),
          children: _chatController.list.map((e) => MessageCard(message: e,)).toList(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                  controller: _chatController.textC,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.blue,
                  onTapOutside: (e)=>FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    filled: true,

                    hintText: 'Ask me anything you want... ',
                    hintStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue, // your color
                        width: 2,
                      ),
                    ),

                  ),
                ),
            ),
            SizedBox(width: mq.width * .02,),
            CircleAvatar(
              backgroundColor: Theme.of(context).buttonColor,
              radius: 24,
              child: IconButton(
                  onPressed: _chatController.askQuestion,
                  icon: Icon(Icons.rocket_launch_rounded,color: Colors.white,size: 28,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
