import 'package:aijokes/app/app_text.dart';
import 'package:flutter/material.dart';

import '../controllers/chat.dart';

class InputFieldWithButton extends StatefulWidget {
  final ChatController chatController;

  InputFieldWithButton({Key? key, required this.chatController})
      : super(key: key);

  @override
  InputFieldWithButtonState createState() => InputFieldWithButtonState();
}

class InputFieldWithButtonState extends State<InputFieldWithButton> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextEntered = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final isTextEntered = _controller.text.isNotEmpty;
      if (isTextEntered != _isTextEntered) {
        setState(() {
          _isTextEntered = isTextEntered;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: screenHeight / 4,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      hintText: 'Введите текст...',
                      suffixIcon: _isTextEntered
                          ? IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () async {
                                String text = _controller.text;
                                _controller.clear();
                                widget.chatController
                                    .addMessage(text);
                                await widget.chatController
                                    .fetchGeneratedText(text);
                              },
                            )
                          : const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.send,
                                color: Colors.black12,
                              )),
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: 48,
                        minWidth: 48,
                      ),
                    ),
                    maxLines: null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const AppText(
            text:
                'Это всего лишь выдумка нейронной сети, не стоит воспримать всерьёз',
            fontSize: 14,
            align: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
