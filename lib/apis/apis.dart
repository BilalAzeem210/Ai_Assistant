import 'dart:convert';

import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/helper/my_dailog.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Apis {
  Future<String> getAnswer(String question) async{
    try {
      final response = await http.post(Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=$apiKey"),
          headers: {
            "Content-Type": "application/json"
          }, body: jsonEncode({
            "contents": [
              {
                "parts": [
                  {
                    "text": "$question"
                  }
                ]
              }
            ]
          })
      );
      final data = jsonDecode(response.body.toString());
      final text = data['candidates'][0]['content']['parts'][0]['text'];

      print("response: $data");
      print(response.body.toString());
      if(kDebugMode){
       print("Answer: $text");
     }
      return text;
    }
    catch(e) {
      if (kDebugMode) {
        print("get Answer Error: ${e.toString()}");
      }

      return "Something went wrong,Please Try Again Later";

    }

  }

  /*Future<Uint8List?> createAiImage(String prompt) async {

    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-image-preview:generateContent',),

        headers: {
          "x-goog-api-key": apiKey,
          'Content-Type':
          'application/json',
        },

        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text": prompt
                }
              ]
            }
          ],

        }),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        final parts = data['candidates'][0]['content']['parts'];

        for (var part in parts) {

          if (part['inlineData'] != null) {

            final base64Image = part["inlineData"]["data"];
            return base64Decode(base64Image);
          }
        }

        return null;
      }
      else {

        debugPrint(response.body);

        return null;
      }

    } catch (e) {

      debugPrint('Image Error: $e');

      return null;
    }
  }
*/
  /*Future<Uint8List?> createAiImage(String prompt) async {
    try {

      final encodedPrompt = Uri.encodeComponent(prompt);

      final url =
          'https://image.pollinations.ai/prompt/$encodedPrompt';

      final response = await http.get(Uri.parse(url));

      debugPrint("STATUS: ${response.statusCode}");

      if (response.statusCode == 200 &&
          response.bodyBytes.isNotEmpty) {

        return response.bodyBytes;

      }
      else {

        debugPrint("RESPONSE: ${response.body}");

        MyDailog.error("Image generation failed");
        return null;
      }

    } catch (e) {

      debugPrint("ERROR: $e");

      MyDailog.error("Check internet or API issue");

      return null;
    }
  }
*/
  Future<Uint8List?> createAiImage(String prompt) async {
    try {
      final url = Uri.parse(
        'https://gen.pollinations.ai/v1/images/generations',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $polinationKey',
        },
        body: jsonEncode({
          "prompt": prompt,
          "model": "flux",
          "n": 1,
          "size": "1024x1024",
          "quality": "medium",
          "response_format": "b64_json",
          "safe": true
        }),
      );

      debugPrint("STATUS: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // usually: data["data"][0]["b64_json"]
        final base64Image = data["data"][0]["b64_json"];

        return base64Decode(base64Image);
      } else {
        debugPrint("RESPONSE: ${response.body}");
        MyDailog.error("Image generation failed");
        return null;
      }
    } catch (e) {
      debugPrint("ERROR: $e");
      MyDailog.error("Check internet or API issue");
      return null;
    }
  }

}






