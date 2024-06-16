import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:login/models/chart.dart';
import 'package:login/messages/message_screen.dart';
import 'package:login/constants.dart';
import 'package:login/app/widgets/primary_tab.dart';

// class PrimaryTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount:conversationController.conversations.length,
//       itemBuilder: (context, index) =>
//           ChatCard(conversation: loadConversations[index]),
//     );
//   }
// }

class ChatCard extends StatelessWidget {
  final Conversation conversation;

  const ChatCard({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessagesScreen(conversation: conversation),
          ),
        );
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
                Text(
                  conversation.text,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
            Text(
              "7:30A.M",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class Conversation {
  final Recipient recipient;
  final String text;
  final DateTime updatedAt;
  int id;

  Conversation({
    required this.recipient,
    required this.text,
    required this.updatedAt,
    required this.id,
  });
}

class Recipient {
  final String name;
  final String image;

  Recipient({required this.name, required this.image});
}

// Demo conversations









