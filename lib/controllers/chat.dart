import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../app/repository.dart';

class ChatController extends GetxController {
  var messages = <Map<bool, String>>[].obs;
  var isLoading = false.obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    // Здесь мы подписываемся на изменения
    isLoading.listen((isLoading) {
      if (isLoading) {
        _scrollToEnd();
      }
    });
    messages.listen((_) {
      // Используем задержку, чтобы дать UI время на обновление
      Future.delayed(const Duration(milliseconds: 100), _scrollToEnd);
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchGeneratedText(String text) async {
    isLoading.value = true;
    final uri = Uri.parse('http://127.0.0.1:8080/generate');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'text': text});

    try {
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

  void _scrollToEnd() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  void isValidRussianString(String input) {
    final RegExp regex = RegExp(r'^[а-яА-ЯёЁ\s.,!?;-]*$');
    if (regex.hasMatch(input)) {
      Repository.instance.chatController.addMessage(input);
      Repository.instance.chatController.fetchGeneratedText(input);
    } else {
      Get.snackbar(
        'Только на русском',
        'Писать сообщения нейронной сети, можно только на русском',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void sendEmpty() {
    Get.snackbar(
      'Пустое сообщение', // Заголовок сообщения
      'Введите начало анекдота. Например: "Как-то раз я приехал в ..."',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
