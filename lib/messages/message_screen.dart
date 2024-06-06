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


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:project/controller/chat_controller.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:project/model/Message.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final Color purple = Color(0xFF6c5ce7);
//   final Color black = Color(0xFF191919);
//   final TextEditingController msgInputController = TextEditingController();
//   late IO.Socket socket;
//   ChatController chatController = ChatController();

//   @override
//   void initState() {
//     super.initState();
//     socket = IO.io('http://localhost:4000', IO.OptionBuilder()
//         .setTransports(['websocket'])
//         .disableAutoConnect()
//         .setExtraHeaders({'foo': 'bar'})
//         .build());
//     socket.connect();
//     setUpSocketListener();
//   }

//   @override
//   void dispose() {
//     socket.dispose();
//     super.dispose();
//   }

//   void setUpSocketListener() {
//     socket.on('message-receive', (data) {
//       setState(() {
//         chatController.chatMessages.add(Message.fromJson(data));
//       });
//     });
//      socket.on('connected-user', (data) {
//       setState(() {
//         chatController.connectedUser.value = data; // Updated this line to use .value
//       });
//     });
//   }

//   void sendMessage(String text) {
//     if (text.isEmpty) return;
//     var messageJson = {
//       "message": text,
//       "sentBy": socket.id
//     };
//     socket.emit('message', messageJson);
//     chatController.chatMessages.add(Message.fromJson(messageJson));
//     msgInputController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: black,
//       body: Column(
//         children: [
//           Obx(
//             () => Container(
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 "Connected User: ${chatController.connectedUser.value}",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.0,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 9,
//             child: Obx(
//               () => ListView.builder(
//                 itemCount: chatController.chatMessages.length,
//                 itemBuilder: (context, index) {
//                   var currentItem = chatController.chatMessages[index];
//                   return MessageItem(
//                     sentBy: currentItem.sentBy == socket.id,
//                     message: currentItem.message,
//                     timestamp: "1:10 A.M", // Adjust as needed
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     style: TextStyle(color: Colors.white),
//                     cursorColor: purple,
//                     controller: msgInputController,
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       hintText: 'Type a message...',
//                       hintStyle: TextStyle(color: Colors.white70),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: purple,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.send, color: Colors.white),
//                     onPressed: () => sendMessage(msgInputController.text),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MessageItem extends StatelessWidget {
//   const MessageItem({
//     Key? key,
//     required this.sentBy,
//     required this.message,
//     required this.timestamp,
//   }) : super(key: key);

//   final bool sentBy;
//   final String message;
//   final String timestamp;

//   @override
//   Widget build(BuildContext context) {
//     final Color purple = Color(0xFF6c5ce7);
//     final Color black = Color(0xFF191919);
//     final Color white = Colors.white;

//     return Align(
//       alignment: sentBy ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
//         decoration: BoxDecoration(
//           color: sentBy ? purple : white,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Column(
//           crossAxisAlignment:
//               sentBy ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(
//               message,
//               style: TextStyle(
//                 color: sentBy ? white : purple,
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               timestamp,
//               style: TextStyle(
//                 color: (sentBy ? white : purple).withOpacity(0.7),
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }