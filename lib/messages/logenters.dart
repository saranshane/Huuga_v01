import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/home/home_screen.dart';
import '../home/primary_tab.dart';

class LogEnters extends StatefulWidget {
  const LogEnters({Key? key}) : super(key: key);

  @override
  State<LogEnters> createState() => _LogEntersState();
}

class _LogEntersState extends State<LogEnters> {
  final List<Conversation> demoConversations = [
    Conversation(
      recipient:
          Recipient(name: 'John Doe', image: 'assets/images/avatar2.png'),
      text: 'Hello, how are you?',
      updatedAt: DateTime.now(),
      id: 1,
    ),
    Conversation(
      recipient:
          Recipient(name: 'Jane Smith', image: 'assets/images/avatar7.png'),
      text: 'Good morning!',
      updatedAt: DateTime.now(),
      id: 2,
    ),
    Conversation(
      recipient:
          Recipient(name: 'Alice Johnson', image: 'assets/images/avatar3.png'),
      text: 'Are you available for a meeting?',
      updatedAt: DateTime.now(),
      id: 3,
    ),
    Conversation(
      recipient:
          Recipient(name: 'Bob Brown', image: 'assets/images/avatar4.png'),
      text: 'Let\'s catch up later.',
      updatedAt: DateTime.now(),
      id: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: demoConversations.length,
          itemBuilder: (context, index) {
            final conversation = demoConversations[index];
            return InkWell(
              onTap: () {
                Get.to(HomeScreen());
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(conversation.recipient.image),
                ),
                title: Text(conversation.recipient.name),
              ),
            );
          },
        ),
      ),
    );
  }
}
