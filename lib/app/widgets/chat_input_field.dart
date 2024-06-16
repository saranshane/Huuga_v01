import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/controllers/chat_controller.dart';

class ChatInputField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController msgInputController;
  final bool show;
  final VoidCallback onSend;

  final ChatController chatController = Get.find<ChatController>();

  ChatInputField({
    Key? key,
    required this.focusNode,
    required this.msgInputController,
    required this.show,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: msgInputController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.message),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.mic),
                                  onPressed: () =>
                                      print('Audio button tapped')),
                              IconButton(
                                icon: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF9431A5),
                                          Color(0xFFAC303B)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Icon(Icons.send_rounded,
                                        size: 18, color: Colors.white),
                                  ),
                                ),
                                onPressed: onSend,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
