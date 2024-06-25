import 'package:flutter/material.dart';
import 'package:login/app/data/models/conversation.dart';

class ChatCard extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ChatCard({Key? key, required this.conversation, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(conversation.recipient.image),
        ),
        title: Text(conversation.recipient.name),
        subtitle: Text(conversation.text),
      ),
    );
  }
}
