import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/controllers/conversation_controller.dart';
import 'package:login/app/data/models/conversation.dart';
import 'package:login/app/widgets/chat_card.dart';

class PrimaryTab extends StatelessWidget {
  final ConversationController conversationController =
      Get.put(ConversationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView.builder(
            itemCount: conversationController.conversations.length,
            itemBuilder: (context, index) {
              Conversation conversation =
                  conversationController.conversations[index];
              return ChatCard(conversation: conversation);
            },
          )),
    );
  }
}
