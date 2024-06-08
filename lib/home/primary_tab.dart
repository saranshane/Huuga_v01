import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login/models/chart.dart';
import 'package:login/messages/message_screen.dart';
import 'package:login/constants.dart';

class PrimaryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: demoConversations.length,
      itemBuilder: (context, index) =>
          ChatCard(conversation: demoConversations[index]),
    );
  }
}

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
final List<Conversation> demoConversations = [
  Conversation(
    recipient: Recipient(name: 'John Doe', image: 'assets/images/avatar2.png'),
    text: 'Hello, how are you?',
    updatedAt: DateTime.now(),
    id: 1,
  ),
  Conversation(
      recipient:
          Recipient(name: 'Jane Smith', image: 'assets/images/avatar7.png'),
      text: 'Good morning!',
      updatedAt: DateTime.now(),
      id: 2),
  Conversation(
      recipient:
          Recipient(name: 'Alice Johnson', image: 'assets/images/avatar3.png'),
      text: 'Are you available for a meeting?',
      updatedAt: DateTime.now(),
      id: 3),
  Conversation(
      recipient:
          Recipient(name: 'Bob Brown', image: 'assets/images/avatar4.png'),
      text: 'Let\'s catch up later.',
      updatedAt: DateTime.now(),
      id: 4),
];










// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   List<Conversation> conversations = []; // List to store fetched chat data
//   bool isLoading = false; // Flag to track loading state

//   @override
//   void initState() {
//     super.initState();
//     fetchChats(); // Fetch chat data when the widget initializes
//   }

//   Future<void> fetchChats() async {
//     setState(() {
//       isLoading = true; // Set loading flag to true
//     });

//     try {
//       final response = await http.get(Uri.parse(
//           'http://localhost:3000/api/conversations/?userId=660be75b9940f152d687a95b')); // Replace 'YOUR_BACKEND_API_URL' with your actual backend API URL

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData =
//             json.decode(response.body); // Parse JSON response
//         final List<dynamic> conversationList = responseData['conversations'];
//         setState(() {
//           conversations = conversationList
//               .map((data) => Conversation.fromJson(data))
//               .toList(); // Convert JSON data to List<Conversation>
//           isLoading = false; // Set loading flag to false
//         });
//       } else {
//         // Handle error
//         print('Failed to load chat data');
//         setState(() {
//           isLoading = false; // Set loading flag to false in case of error
//         });
//       }
//     } catch (e) {
//       // Handle network or parsing errors
//       print('Error fetching chat data: $e');
//       setState(() {
//         isLoading = false; // Set loading flag to false in case of error
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: isLoading
//               ? Center(
//                   child:
//                       CircularProgressIndicator()) // Show loading indicator while fetching data
//               : ListView.builder(
//                   itemCount: conversations.length,
//                   itemBuilder: (context, index) => ChatCard(
//                     conversation: conversations[index],
//                     press: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MessageScreen(),
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       ],
//     );
//   }
// }

// class ChatCard extends StatelessWidget {
//   final Conversation conversation;
//   final VoidCallback press;

//   const ChatCard({
//     Key? key,
//     required this.conversation,
//     required this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: press,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 24,
//               // backgroundImage: AssetImage(conversation.recipients[0].image), // Assuming the first recipient's image is used
//             ),
//             Expanded(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       conversation.recipients[1]
//                           .name, // Assuming the first recipient's name is used
//                       style:
//                           TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(height: 8),
//                     Opacity(
//                       opacity: 0.64,
//                       child: Text(
//                         conversation
//                             .text, // Assuming the conversation text is used
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Opacity(
//               opacity: 0.64,
//               child: Text(conversation.updatedAt
//                   .toString()), // Assuming updatedAt is used
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }