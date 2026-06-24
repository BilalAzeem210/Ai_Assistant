import 'package:ai_assistant/model/home_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class HomeCard extends StatelessWidget {
  final HomeType homeType;
  const HomeCard({super.key, required this.homeType});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    Size dq = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.only(bottom: dq.height * .02),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      color: Colors.blue.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: homeType.onTap,
        child: homeType.leftAlign ? Row(
          children: [
            Container(
              padding: homeType.Padding,
              width: dq.width * .35,
              child: Lottie.asset('assets/lottie/${homeType.lottie}',
                  ),
            ),

            SizedBox(width: dq.width * .06,),

            Text(homeType.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 1
              ),
            ),
          ],
        )
            : Row(
          children: [
            SizedBox(width: dq.width * .09,),
            Text(homeType.title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 1
              ),
            ),

           Spacer(),
            Container(
              width: dq.width * .35,
              padding: homeType.Padding,
              child: Lottie.asset('assets/lottie/${homeType.lottie}',
                  ),
            ),

          ],
        ),
      ),
    ).animate().scale(duration: Duration(seconds: 1));
  }
}
