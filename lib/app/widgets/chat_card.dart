import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/controllers/chat_controller.dart';
import 'package:login/app/data/models/conversation.dart'; // Adjust import path as per your project structure
import 'package:login/messages/message_screen.dart';

class ChatCard extends StatelessWidget {
  final Conversation conversation;

  const ChatCard({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MessagesScreen(conversation: conversation),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(conversation.recipient.image),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.recipient.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Obx(() {
                  // Observe changes in messages list
                  final messages = chatController.messages;
                  if (messages.isEmpty) {
                    return Text(
                      'No messages yet',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    );
                  } else {
                    // Display the last message in the list
                    final lastMessage = messages.last;
                    return Text(
                      lastMessage.text,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    );
                  }
                }),
              ],
            ),
            Spacer(),
            Text(
              "7:30 AM",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
