import 'package:aijokes/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/app_text.dart';
import '../app/repository.dart';
import '../controllers/chat.dart';
import '../widgets/input_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'AI Jokes',
        fontWeight: FontWeight.bold,
        fontSize: 30,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  controller: Repository.instance.chatController.scrollController,
                  itemCount: Repository.instance.chatController.messages.length +
                      (Repository.instance.chatController.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= Repository.instance.chatController.messages.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Генерируем анекдот..."),
                              SizedBox(width: 10),
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      );
                    } else {
                      bool isUserMessage =
                          Repository.instance.chatController.messages[index].keys.first;
                      String messageText =
                      Repository.instance.chatController.messages[index][isUserMessage]!;
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 10),
                        decoration: BoxDecoration(
                            color: isUserMessage
                                ? Colors.transparent
                                : Colors.black),
                        child: ListTile(
                          title: AppText(
                            text: messageText,
                            color: isUserMessage ? Colors.black : Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                )),
          ),
          InputFieldWithButton(chatController: Repository.instance.chatController),
        ],
      ),
    );
  }
}
