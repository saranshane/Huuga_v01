// import 'package:flutter/material.dart';
// // import 'package:login/app/data/models/chat_message.dart';
// // import 'package:login/messages/message_screen.dart';

// class MessageWidget extends StatelessWidget {
//   final ChatMessage message;
//   final String recipientImage;
//   final bool sentBy;

//   const MessageWidget({
//     Key? key,
//     required this.message,
//     required this.recipientImage,
//     required this.sentBy,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment:
//           sentBy ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         if (!sentBy)
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 0.0),
//             child: CircleAvatar(
//                 radius: 12.0, backgroundImage: AssetImage(recipientImage)),
//           ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(top: 8.0),
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//               decoration: BoxDecoration(
//                 color: sentBy ? Colors.blue : Colors.grey[300],
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Text(
//                 message.text,
//                 style: TextStyle(color: sentBy ? Colors.white : Colors.black),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }