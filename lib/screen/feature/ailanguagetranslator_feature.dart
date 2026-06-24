import 'package:ai_assistant/controllers/image_controller.dart';
import 'package:ai_assistant/controllers/translate_controller.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/widgets/custom_btn.dart';
import 'package:ai_assistant/widgets/custom_loading.dart';
import 'package:ai_assistant/widgets/language_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AilanguagetranslatorFeature extends StatefulWidget {
  const AilanguagetranslatorFeature({super.key});

  @override
  State<AilanguagetranslatorFeature> createState() => _AilanguagetranslatorFeatureState();
}

class _AilanguagetranslatorFeatureState extends State<AilanguagetranslatorFeature> {

 final TranslateController _c = Get.put(TranslateController());
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Multi Language Translator"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top:mq.height * .02,
            bottom: mq.height * .12,),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: ()=> Get.bottomSheet(LanguageSheet(c: _c, s: _c.from,)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: mq.height * .06,
                  width: mq.width * .4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Obx(()=>Text(_c.from.isEmpty ? 'Auto' : _c.from.value),)
                ),
              ),
              IconButton(onPressed: _c.swapLanguage,
                  icon: Obx(
                          ()=> Icon(CupertinoIcons.repeat,
                    color: _c.to.isNotEmpty && _c.from.isNotEmpty ? Colors.blue :
                    Colors.grey,),
                  ),
              ),
              InkWell(
                onTap: ()=> Get.bottomSheet(LanguageSheet(c: _c, s: _c.to,)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                    height: mq.height * .06,
                    width: mq.width * .4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Obx(()=>Text(_c.to.isEmpty ? 'To' : _c.to.value),)
                ),
              ),
            ],
          ),
          /*SizedBox(height: mq.height * .01,),
*/
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: mq.height * .035),
            child: TextFormField(
             controller: _c.textC,
              cursorColor: Colors.blue,
              minLines: 5,
              maxLines: null,
              onTapOutside: (e)=>FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: 'Translate Anything You Want...',
                hintStyle: TextStyle(fontSize: 13.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
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

          Obx(()=>_aiTranslate()),

          SizedBox(height: mq.height * .04,),
          CustomBtn(text: 'Translate', onTap: _c.translate),
        ],
      ),
    );
  }
 Widget _aiTranslate() =>
     switch (_c.status.value) {

       Status.none => SizedBox(),

       Status.complete => Padding(
         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .04,),
         child: TextFormField(
           controller: _c.resultC,
           cursorColor: Colors.blue,
           maxLines: null,
           readOnly: true,
           onTapOutside: (e)=>FocusScope.of(context).unfocus(),
           decoration: InputDecoration(
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
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
       Status.loading => const Align(child: CustomLoading()),
     };
}
