import 'package:aijokes/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/app_text.dart';
import '../controllers/chat.dart';
import '../widgets/input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatController chatController = Get.put(ChatController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatController.isLoading.listen((isLoading) {
      if (isLoading) {
        _scrollToEnd();
      }
    });
    chatController.messages.listen((_) {
      Future.delayed(const Duration(milliseconds: 100), _scrollToEnd);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
                  controller: scrollController,
                  itemCount: chatController.messages.length +
                      (chatController.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= chatController.messages.length) {
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
                          chatController.messages[index].keys.first;
                      String messageText =
                          chatController.messages[index][isUserMessage]!;
                      return Container(
                        margin: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          bottom: 10,
                        ),
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
          InputFieldWithButton(chatController: chatController),
        ],
      ),
    );
  }
}
