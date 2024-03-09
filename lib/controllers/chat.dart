import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatController extends GetxController {
  var messages = <Map<bool, String>>[].obs;
  var isLoading = false.obs;

  Future<void> fetchGeneratedText(String text) async {
    isLoading.value = true;
    final uri = Uri.parse('http://127.0.0.1:8080/generate');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'text': text});

    try {
      isLoading.value = true;
      final httpResponse = await http.post(uri, headers: headers, body: body);
      if (httpResponse.statusCode == 200) {
        final jsonResult = json.decode(httpResponse.body);
        messages.add({false: jsonResult['generated_text']});
      } else {
        if (kDebugMode) {
          print('Server error: ${httpResponse.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('HTTP request failed: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void addMessage(String message) {
    messages.add({true: message});
  }
}
