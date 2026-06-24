import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/model/message.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final Message message;
   MessageCard({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
     final r = BorderRadius.circular(15);
    return message.type == MessageType.bot ?
    //for bot
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 6,),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Image.asset('assets/images/appicon.png',width: 24,)
        ),

        Container(
          constraints: BoxConstraints(maxWidth: mq.width * .6),
          margin: EdgeInsets.only(bottom: mq.height * .02,
          left: mq.width * .02),
          padding: EdgeInsets.symmetric(
            vertical: mq.height * .01,
            horizontal: mq.width * .03,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).lightTextColor),
            borderRadius: BorderRadius.only(
              topLeft: r.topLeft,
              topRight: r.topRight,
              bottomRight: r.bottomRight,
            )
          ),

        child: message.msg.isEmpty ? AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Please wait ...',
                speed: const Duration(milliseconds: 200),
              ),
            ],

            repeatForever: true,

        ) :
        Text(message.msg ,textAlign: TextAlign.center,),

        ),
      ],
    ) : //for user
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: mq.width * .6),
          margin: EdgeInsets.only(bottom: mq.height * .02,
              right: mq.width * .02),
          padding: EdgeInsets.symmetric(
            vertical: mq.height * .01,
            horizontal: mq.width * .03,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).lightTextColor),
              borderRadius: BorderRadius.only(
                topLeft: r.topLeft,
                topRight: r.topRight,
                bottomLeft: r.bottomLeft,
              )
          ),
          child: Text(message.msg ,textAlign: TextAlign.center,),
        ),
        CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(Icons.person,color: Colors.blue,size: 24,)
        ),
        const SizedBox(width: 6,),

      ],
    );
  }
}
