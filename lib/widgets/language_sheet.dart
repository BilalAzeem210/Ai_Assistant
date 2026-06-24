import "package:ai_assistant/controllers/translate_controller.dart";
import "package:ai_assistant/helper/global.dart";
import"package:flutter/material.dart";
import "package:get/get_core/src/get_main.dart";
import "package:get/get_navigation/src/extension_navigation.dart";
import "package:get/get_rx/src/rx_types/rx_types.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart";

class LanguageSheet extends StatefulWidget {
 final TranslateController c;
 final RxString s;
  const LanguageSheet({super.key, required this.c, required this.s});

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  final _search = ''.obs;
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height * .5,
      padding: EdgeInsets.only(
        top: mq.height * .02,
        left: mq.width * .04,
        right: mq.width * .04,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          TextFormField(
            onChanged: (s)=>_search.value=s.toLowerCase(),
            onTapOutside: (e)=>FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.translate_rounded,color: Colors.blue,),
              hintText: 'Search Language...',
              hintStyle: TextStyle(fontSize: 13.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: Obx((){
              final List<String> list = _search.isEmpty ? widget.c.lang
                  : widget.c.lang.where((e)=>e.toLowerCase().contains(_search.value)).toList();
              return ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(top: mq.height * .02,left: 6),
                  itemBuilder: (ctx,index){
                    return InkWell(
                      onTap:(){
                        widget.s.value = list[index];
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: mq.height * .02),
                        child: Text(list[index]),
                      ),
                    );
                  });
            }),
          )

        ],
      ),
    );
  }
}
