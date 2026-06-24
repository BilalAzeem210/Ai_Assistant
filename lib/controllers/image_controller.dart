import 'dart:io';
import 'dart:typed_data';
import 'package:ai_assistant/apis/apis.dart';
import 'package:ai_assistant/helper/my_dailog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';

enum Status {
  none,
  loading,
  complete,
}

class ImageController extends GetxController {

  final status = Status.none.obs;

  final imageBytes = Rx<Uint8List?>(null);

  final imageText = TextEditingController();

  final getApi = Apis();

  Future<void> generateImage() async {

    if (imageText.text.trim().isNotEmpty) {
      status.value = Status.loading;

      final result = await getApi.createAiImage(
        imageText.text,
      );

      if (result != null) {
        imageBytes.value = result;

        status.value = Status.complete;
      } else {


        status.value = Status.none;
        MyDailog.error("Something went wrong");
      }
    }
    else{
      MyDailog.info("Provide Some Beautiful Image Description");
    }
    }
  Future<void> saveToGallery() async {

    try {

      final bytes = imageBytes.value;

      if (bytes == null) {
        MyDailog.info("No image available");
        return;
      }

      final result = await SaverGallery.saveImage(
        bytes,
        quality: 90,
        fileName:
        "ai_image_${DateTime.now().millisecondsSinceEpoch}.jpg",
        skipIfExists: false,
      );

      if (result.isSuccess) {
        MyDailog.success("Saved to Gallery");
      } else {
        MyDailog.error("Save failed");
      }

    } catch (e) {
      debugPrint("SAVE ERROR: $e");
      MyDailog.error("Save crashed: $e");
    }
  }

  Future<void> shareImage() async {

    try {

      if (imageBytes.value == null) {
        MyDailog.info("No image to share");
        return;
      }

      final tempDir =
      await getTemporaryDirectory();

      final file = File(
        '${tempDir.path}/ai_image.png',
      );

      await file.writeAsBytes(
        imageBytes.value!,
      );

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Generated with AI Assistant',
      );

    } catch (e) {
      MyDailog.error(
        'Share Failed: $e',
      );
    }
  }


  }
