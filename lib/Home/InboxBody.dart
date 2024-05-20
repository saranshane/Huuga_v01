import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login/models/chart.dart';
import 'package:login/Messages/MessageScreen.dart';
import 'package:login/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Conversation> conversations = []; // List to store fetched chat data
  bool isLoading = false; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    fetchChats(); // Fetch chat data when the widget initializes
  }

  Future<void> fetchChats() async {
    setState(() {
      isLoading = true; // Set loading flag to true
    });

    try {
      final response = await http.get(Uri.parse(
          'http://localhost:3000/api/conversations/?userId=660be75b9940f152d687a95b')); // Replace 'YOUR_BACKEND_API_URL' with your actual backend API URL

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            json.decode(response.body); // Parse JSON response
        final List<dynamic> conversationList = responseData['conversations'];
        setState(() {
          conversations = conversationList
              .map((data) => Conversation.fromJson(data))
              .toList(); // Convert JSON data to List<Conversation>
          isLoading = false; // Set loading flag to false
        });
      } else {
        // Handle error
        print('Failed to load chat data');
        setState(() {
          isLoading = false; // Set loading flag to false in case of error
        });
      }
    } catch (e) {
      // Handle network or parsing errors
      print('Error fetching chat data: $e');
      setState(() {
        isLoading = false; // Set loading flag to false in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isLoading
              ? Center(
                  child:
                      CircularProgressIndicator()) // Show loading indicator while fetching data
              : ListView.builder(
                  itemCount: conversations.length,
                  itemBuilder: (context, index) => ChatCard(
                    conversation: conversations[index],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageScreen(),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class ChatCard extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback press;

  const ChatCard({
    Key? key,
    required this.conversation,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              // backgroundImage: AssetImage(conversation.recipients[0].image), // Assuming the first recipient's image is used
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conversation.recipients[1]
                          .name, // Assuming the first recipient's name is used
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        conversation
                            .text, // Assuming the conversation text is used
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(conversation.updatedAt
                  .toString()), // Assuming updatedAt is used
            ),
          ],
        ),
      ),
    );
  }
}
