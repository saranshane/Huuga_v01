// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:login/constants.dart';
// import 'package:login/questions/questions_screen.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:get/get.dart';
// import 'package:login/app/widgets/primary_tab.dart';

// class MessagesScreen extends StatefulWidget {
//   final Conversation conversation;

//   const MessagesScreen({Key? key, required this.conversation})
//       : super(key: key);

//   @override
//   _MessagesScreenState createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen> {
//   late IO.Socket socket;
//   final TextEditingController msgInputController = TextEditingController();
//   final FocusNode focusNode = FocusNode();
//   late Timer _timer;
//   int _timeLeft = 500;
//   bool show = false;
//   List<ChatMessage> chatMessages = [];

//   @override
//   void initState() {
//     super.initState();
//     connect();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           show = false;
//         });
//       }
//     });
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     socket.dispose();
//     msgInputController.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }

//   void connect() {
//     socket = IO.io(
//       "http://localhost:4000",
//       <String, dynamic>{
//         "transports": ["websocket"],
//         "autoConnect": false,
//       },
//     );
//     socket.connect();
//     socket.onConnect((_) {
//       print("connected");
//       socket.emit("/test", "Hello World");
//     });
//     socket.onConnectError((data) {
//       print("Connect Error: $data");
//     });
//     socket.onError((data) {
//       print("Error: $data");
//     });
//     socket.onDisconnect((data) {
//       print("Disconnected: $data");
//     });
//     socket.on('message', (data) {
//       setState(() {
//         chatMessages.add(ChatMessage.fromJson(data));
//       });
//     });
//     print(socket.connected);
//   }

//   void setUpSocketListener() {
//     socket.on('message-receive', (data) {
//       setState(() {
//         chatMessages.add(ChatMessage.fromJson(data));
//       });
//     });
//     socket.on('connected-user', (data) {
//       setState(() {
//         connectedUser.value = data;
//       });
//     });
//   }

//   void sendMessage(String text) {
//     if (text.isEmpty) return;
//     var messageJson = {"message": text, "sentBy": socket.id};
//     socket.emit('message', messageJson);
//     setState(() {
//       chatMessages.add(ChatMessage.fromJson(messageJson));
//     });
//     msgInputController.clear();
//   }

//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(oneSec, (Timer timer) {
//       setState(() {
//         if (_timeLeft < 1) {
//           timer.cancel();
//           _showBottomSheet();
//         } else {
//           _timeLeft -= 1;
//         }
//       });
//     });
//   }

//   void _showBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Row(
//                     children: [
//                       Icon(Icons.timer, size: 14),
//                       SizedBox(width: 2),
//                       Text('0 secs left', style: TextStyle(fontSize: 12)),
//                       SizedBox(width: 10),
//                       Text('FAQs', style: TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(Icons.cancel_outlined),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Image.asset('assets/images/Q_banner.jpeg',
//                   width: 200, height: 200, fit: BoxFit.cover),
//               const SizedBox(height: 10),
//               Text(
//                 'Keep The Conversation going with @${widget.conversation.recipient.name}',
//                 style:
//                     const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//               const Spacer(),
//               Flexible(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text("Extend the chat by 10 Minutes?",
//                         style: TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.bold)),
//                     const SizedBox(width: 5),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => QuestionsScreen()));
//                       },
//                       child: const Text(
//                         "Answer the simple Questions",
//                         style:
//                             TextStyle(fontSize: 12, color: Color(0xFFAC303B)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => QuestionsScreen()));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                 ),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                         colors: [Color(0xFF9431A5), Color(0xFFAC303B)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.topRight),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Container(
//                     constraints:
//                         const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
//                     alignment: Alignment.center,
//                     child: const Text('Start Now',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                         textAlign: TextAlign.center),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () => Navigator.pop(context)),
//             CircleAvatar(
//                 backgroundImage:
//                     AssetImage(widget.conversation.recipient.image)),
//             const SizedBox(width: 8),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.conversation.recipient.name,
//                     style: const TextStyle(fontSize: 16)),
//                 const Text("Active 3m ago", style: TextStyle(fontSize: 12)),
//               ],
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(40),
//                       border: Border.all(color: Colors.grey)),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.timer, size: 14),
//                       const SizedBox(width: 2),
//                       Text('${_timeLeft} secs left',
//                           style: const TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                 ),
//                 IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: chatMessages.length,
//               itemBuilder: (context, index) {
//                 var currentItem = chatMessages[index];
//                 return MessageWidget(
//                   sentBy: currentItem.sentBy == socket.id,
//                   message: currentItem,
//                   recipientImage: widget.conversation.recipient.image,
//                 );
//               },
//             ),
//           ),
//           ChatInputField(
//             focusNode: focusNode,
//             msgInputController: msgInputController,
//             show: show,
//             onSend: _handleSend,
//           ),
//         ],
//       ),
//     );
//   }

//   void _handleSend() {
//     if (!show) {
//       focusNode.unfocus();
//       focusNode.canRequestFocus = false;
//     }
//     sendMessage(msgInputController.text);
//     setState(() {
//       show = !show;
//     });
//   }
// }

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
//                 color: sentBy ? kPrimaryColor : kPrimaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Text(
//                 message.text,
//                 style:
//                     TextStyle(color: sentBy ? Colors.white : kSecondaryColor),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class ChatInputField extends StatelessWidget {
//   final FocusNode focusNode;
//   final TextEditingController msgInputController;
//   final bool show;
//   final VoidCallback onSend;

//   const ChatInputField({
//     Key? key,
//     required this.focusNode,
//     required this.msgInputController,
//     required this.show,
//     required this.onSend,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//       decoration:
//           BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 decoration: BoxDecoration(
//                     color: kPrimaryColor.withOpacity(0.05),
//                     borderRadius: BorderRadius.circular(40)),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: msgInputController,
//                         focusNode: focusNode,
//                         decoration: InputDecoration(
//                           hintText: 'Type a message...',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 10.0),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20.0)),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                           prefixIcon: const Icon(Icons.emoji_emotions_outlined),
//                           suffixIcon: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                   icon: const Icon(Icons.mic),
//                                   onPressed: () =>
//                                       print('Audio button tapped')),
//                               IconButton(
//                                 icon: Container(
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     gradient: LinearGradient(
//                                         colors: [
//                                           Color(0xFF9431A5),
//                                           Color(0xFFAC303B)
//                                         ],
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight),
//                                   ),
//                                   child: const Padding(
//                                     padding: EdgeInsets.all(6.0),
//                                     child: Icon(Icons.send_rounded,
//                                         size: 18, color: Colors.white),
//                                   ),
//                                 ),
//                                 onPressed: onSend,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChatMessage {
//   final String text;
//   final bool isSender;
//   final String sentBy;

//   ChatMessage({
//     required this.text,
//     required this.isSender,
//     required this.sentBy,
//   });

//   factory ChatMessage.fromJson(Map<String, dynamic> json) {
//     return ChatMessage(
//       text: json['message'],
//       isSender: json['sentBy'] == json['socketId'],
//       sentBy: json['sentBy'],
//     );
//   }
// }

// var connectedUser = 0.obs;
