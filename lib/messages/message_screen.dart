import 'dart:async';
import 'package:login/questions/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:login/home/primary_tab.dart';
import 'package:login/constants.dart';

class MessagesScreen extends StatefulWidget {
  final Conversation conversation;

  const MessagesScreen({super.key, required this.conversation});

  @override
  // ignore: library_private_types_in_public_api
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late Timer _timer;
  int _timeLeft = 5; // Initial time in seconds (2 minutes)

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_timeLeft < 1) {
            timer.cancel();
            // Show bottom sheet here
            _showBottomSheet();
          } else {
            _timeLeft -= 1;
          }
        });
      },
    );
  }

  void decreaseTimer() {
    if (_timeLeft >= 5) return; // Timer can't be less than 0
    setState(() {
      _timeLeft -= 5; // Decrease by 2 minutes
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.timer, size: 14),
                      SizedBox(width: 2),
                      Text(
                        '0 secs left', // Display remaining seconds
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'FAQs', // Display FAQ text
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle the click event
                      // For example, you can show an FAQ dialog here
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                    ), // Right arrow icon
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/Q_banner.jpeg', // Path to your image asset
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
                fit: BoxFit.cover, // Adjust fit as needed
              ),
              const SizedBox(
                  height: 10), // Add some space between the image and the text
              Text(
                'Keep The Conversation going with @${widget.conversation.recipient.name}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                  height:
                      10), // Add some space between the text and the options
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Extend the chat by 10 Minutes?",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5), // Adjust the width as needed
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionsScreen()),
                        );
                      },
                      child: const Text(
                        "Answer the simple Questions",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFAC303B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF9431A5),
                        Color(0xFFAC303B),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Start Now',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CircleAvatar(
            backgroundImage: AssetImage(widget.conversation.recipient.image),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.conversation.recipient.name,
                style: const TextStyle(fontSize: 16),
              ),
              const Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.timer, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      '${_timeLeft % 5} secs left', // Display remaining seconds
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: demoChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demoChatMessages[index]),
            ),
          ),
        ), // Expanded
        const ChatInputField(),
      ],
    );
  }
}

class Message extends StatelessWidget {
  // ignore: use_super_parameters
  const Message({
    required this.message,
    Key? key,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    // Define a fixed width for the circle avatar and SizedBox
    const double avatarSize = 24.0;
    const double spacing = 8.0;

    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isSender) ...[
          const SizedBox(
            width:
                avatarSize + spacing, // Total width for the avatar and spacing
            child: CircleAvatar(
              radius: avatarSize / 2,
              backgroundImage: AssetImage('assets/images/avatar7.png'),
            ),
          ),
          // Spacing between the avatar and message
        ],
        TextMessage(
          message: message,
        ),
      ],
    );
  }
}

class TextMessage extends StatelessWidget {
  // ignore: use_super_parameters
  const TextMessage({
    required this.message,
    Key? key,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kDefaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color:
            message.isSender ? kPrimaryColor : kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.isSender ? Colors.white : kSecondaryColor,
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 0.10),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon:
                                const Icon(Icons.emoji_emotions_outlined),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print('Audio button tapped');
                                  },
                                  icon: const Icon(Icons.mic),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print('Send button tapped');
                                  },
                                  icon: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF9431A5),
                                          Color(0xFFAC303B),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Icon(Icons.send_rounded,
                                          size: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ChatMessageType { text, audio, image, video }

// ignore: constant_identifier_names
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    required this.text,
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

List demoChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Hello, How are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: "Hi Sajol,",
    messageType: ChatMessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Hello, How are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
];




































// import 'package:flutter/material.dart';
// import 'package:login/home/home_screen.dart';
// import '../constants.dart';
// import 'package:login/models/chat_message.dart';

// class MessageScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: Body(),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       title: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomeScreen()),
//               );
//             },
//           ),
//           CircleAvatar(
//             backgroundImage: AssetImage("assets/images/avatar3.png"),
//           ),
//           SizedBox(width: kDefaultPadding * 0.75),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Kristin Watson",
//                 style: TextStyle(fontSize: 16),
//               ),
//               Text(
//                 "Active 3m ago",
//                 style: TextStyle(fontSize: 12),
//               ),
//             ],
//           ),
//           Spacer(),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(40),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.timer, size: 14),
//                     SizedBox(width: 2),
//                     Text(
//                       '40 mins left',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.more_vert),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: ListView.builder(
//               itemCount: demoChatMessages.length,
//               itemBuilder: (context, index) =>
//                   Message(message: demoChatMessages[index]),
//             ),
//           ),
//         ),
//         ChatInputField(),
//       ],
//     );
//   }
// }

// class Message extends StatelessWidget {
//   const Message({
//     required this.message,
//     Key? key,
//   }) : super(key: key);

//   final ChatMessage message;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment:
//           message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         if (!message.isSender) ...[
//           CircleAvatar(
//             radius: 12,
//             backgroundImage: AssetImage("assets/images/avatar3.png"),
//           ),
//           SizedBox(width: kDefaultPadding / 2),
//         ],
//         TextMessage(message: message),
//       ],
//     );
//   }
// }

// class TextMessage extends StatelessWidget {
//   const TextMessage({
//     required this.message,
//     Key? key,
//   }) : super(key: key);

//   final ChatMessage message;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: kDefaultPadding),
//       padding: EdgeInsets.symmetric(
//         horizontal: kDefaultPadding * 0.75,
//         vertical: kDefaultPadding / 2,
//       ),
//       decoration: BoxDecoration(
//         color:
//             message.isSender ? kPrimaryColor : kPrimaryColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Text(
//         message.text,
//         style: TextStyle(
//           color: message.isSender ? Colors.white : kSecondaryColor,
//         ),
//       ),
//     );
//   }
// }

// class ChatInputField extends StatelessWidget {
//   const ChatInputField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: kDefaultPadding,
//         vertical: kDefaultPadding / 2,
//       ),
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.10),
//                 decoration: BoxDecoration(
//                   color: kPrimaryColor.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         height: 50,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Type a message...',
//                             hintStyle: TextStyle(color: Colors.grey),
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 10.0),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                             prefixIcon: Icon(Icons.emoji_emotions_outlined),
//                             suffixIcon: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   onPressed: () {
//                                     print('Audio button tapped');
//                                   },
//                                   icon: Icon(Icons.mic),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     print('Send button tapped');
//                                   },
//                                   icon: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color(0xFF9431A5),
//                                           Color(0xFFAC303B),
//                                         ],
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(6.0),
//                                       child: Icon(Icons.send_rounded,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
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
