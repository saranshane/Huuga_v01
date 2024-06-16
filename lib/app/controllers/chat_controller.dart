import 'package:get/get.dart';
import 'package:login/app/data/models/conversation.dart'; // Adjust import path as per your project structure

class ChatController extends GetxController {
  RxList<Message> messages = <Message>[].obs;

  @override
  void onInit() {
    // Replace with actual data fetching logic
    loadMessages();
    super.onInit();
  }

  void loadMessages() {
    // Example: Load messages for a specific conversation
    List<Message> loadedMessages = [
      Message(text: 'Hello!', sender: Sender.self, time: DateTime.now()),
      Message(text: 'Hi there!', sender: Sender.other, time: DateTime.now()),
      // Add more messages as needed
    ];

    messages.value = loadedMessages;
  }

  void sendMessage(String text) {
    // Example: Send message logic
    messages
        .add(Message(text: text, sender: Sender.self, time: DateTime.now()));
    // Replace with actual logic to send message to backend or service
  }
}

enum Sender {
  self,
  other,
}

class Message {
  final String text;
  final Sender sender;
  final DateTime time;

  Message({
    required this.text,
    required this.sender,
    required this.time,
  });
}
