import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/model/onboard.dart';
import 'package:ai_assistant/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final mq = MediaQuery.of(context).size;
    final list = [

      //Onboarding 1
      Onboard(title: 'Ask me Anything',
          subtitle: 'I can be your Best Friend & You can ask me anything & I will answer it for you',
          lottie: 'ai_ask_me'),
      
      //Onboarding 2
      Onboard(title: 'Imagination to Reality',
          subtitle: 'Just Imagine anything & let me know. I will create something wonderful for you',
          lottie: 'ai_play')
    ];

    return Scaffold(
      body: PageView.builder(
          controller: controller,
          itemCount: list.length,
          itemBuilder: (ctx, index){
            final isLastPage = index == list.length - 1;
        return Column(
          children: [
            Lottie.asset('assets/lottie/${list[index].lottie}.json',
                height: mq.height * .6,width: isLastPage ? mq.width * .7 : null),

            //title
             Text('${list[index].title}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .5
              ),
            ),

            //for adding some space
            SizedBox(height: mq.height * .02,),

            //subtitle

            SizedBox(
              width: mq.width * .7,
              child: Text('${list[index].subtitle}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13.5,
                      letterSpacing: .5,
                      color: Theme.of(context).lightTextColor,
                  )
              ),

            ),

            Spacer(),
            //dots

            Wrap(
              spacing: 10,
              children: List.generate(
                list.length,
                    (i) => Container(
                  width: i == index ? 15 : 10,
                  height: 8,
                  decoration: BoxDecoration(
                      color: i == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(5))

                  ),
                ),
              ),
            ),

            Spacer(),
            //button

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: const StadiumBorder(),
                elevation: 0,
                minimumSize: Size(mq.width * .4, 50),
              ),
              onPressed: (){
                if(isLastPage){
                  Get.off(()=> const HomeScreen());
                  /*Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );*/
                }
                else{
                  controller.nextPage(duration:
                  const Duration(microseconds: 700),
                      curve: Curves.ease);
                }


              },
              child: Text(isLastPage ? 'Finished' : 'Get Started',style:
              TextStyle(
                  color: Colors.white,
                  fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),

            Spacer(flex: 3,)
          ],
        );
      })
    );
  }
}
