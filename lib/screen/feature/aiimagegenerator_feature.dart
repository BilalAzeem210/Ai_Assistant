import 'package:ai_assistant/controllers/image_controller.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/widgets/custom_btn.dart';
import 'package:ai_assistant/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AiimagegeneratorFeature extends StatefulWidget {
  const AiimagegeneratorFeature({super.key});

  @override
  State<AiimagegeneratorFeature> createState() => _AiimagegeneratorFeatureState();
}

class _AiimagegeneratorFeatureState extends State<AiimagegeneratorFeature> {
  final _imageController = ImageController();
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ai Image Generator"),
      actions: [
        Obx( () => _imageController.status.value == Status.complete ?
        IconButton(
            onPressed: _imageController.shareImage,
            color: Theme.of(context).buttonColor,
            icon: Icon(Icons.share,color: Colors.blue,))
        : SizedBox()
        ),
      ],

      ),

      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top:mq.height * .02,
            bottom: mq.height * .12,
            left: mq.width * .04,
            right: mq.width * .04),
        children: [
          TextFormField(
            controller: _imageController.imageText,
            textAlign: TextAlign.center,
            cursorColor: Colors.blue,
            minLines: 2,
            maxLines: null,
            onTapOutside: (e)=>FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              hintText: 'Imagine something you want to generate...\n Type Here & I will create to you',
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

          //Ai Image
          Container(
            margin: EdgeInsets.symmetric(vertical: mq.height * .012),
            height: mq.height * .4,
            alignment: Alignment.center,
            child: Obx(
                    () => _aiImage()
            )
          ),

          CustomBtn(text: 'Generate', onTap: _imageController.generateImage),
        ],
      ),
      floatingActionButton: Obx(()=>_imageController.status.value == Status.complete
      ? Padding(
        padding: const EdgeInsets.only(right: 6, bottom: 6),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).buttonColor,
          onPressed: _imageController.saveToGallery,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(Icons.save_alt_rounded,size: 26,),),
      ) :
      SizedBox()
      )


    );


  }
  Widget _aiImage() =>

      switch (_imageController.status.value) {

        Status.none => Lottie.asset(
          'assets/lottie/ai_play.json',
          height: MediaQuery.of(context).size.height * .3,
        ),

        Status.loading => CustomLoading(),

        Status.complete => _imageController.imageBytes.value != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.memory(
            _imageController.imageBytes.value!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        )
            : const SizedBox(),
      };
}
