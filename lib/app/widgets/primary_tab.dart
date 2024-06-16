import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/data/models/conversation.dart'; // Adjust import path as per your project structure
import 'package:login/app/widgets/chat_card.dart'; // Adjust import path as per your project structure

class ConversationController extends GetxController {
  RxList<Conversation> conversations = <Conversation>[].obs;

  @override
  void onInit() {
    // Replace with actual data fetching logic
    loadConversations();
    super.onInit();
  }

  void loadConversations() {
    // Example: Load conversations from a service or database
    List<Conversation> loadedConversations = [
      Conversation(
        recipient:
            Recipient(name: 'Recipient 1', image: 'assets/images/avatar3.png'),
        text: 'Hello there!',
        updatedAt: DateTime.now(),
        id: 1,
      ),
      Conversation(
        recipient:
            Recipient(name: 'Recipient 2', image: 'assets/images/avatar4.png'),
        text: 'Hi!',
        updatedAt: DateTime.now(),
        id: 2,
      ),
      // Add more conversations as needed
    ];

    conversations.value = loadedConversations;
  }
}

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
