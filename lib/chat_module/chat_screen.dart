import 'package:flutter/material.dart';
import 'package:women_safety_app/chat_module/message_text_field.dart';
import 'package:women_safety_app/chat_module/singleMessage.dart';

// Dummy data for chat messages
List<Map<String, dynamic>> dummyMessages = [
  {
    'senderId': 'user1',
    'message': 'Hello!',
    'date': DateTime.now(),
    'type': 'text'
  },
  {
    'senderId': 'user2',
    'message': 'Hi there!',
    'date': DateTime.now(),
    'type': 'text'
  },
];

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;

  const ChatScreen({
    Key? key,
    required this.currentUserId,
    required this.friendId,
    required this.friendName,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? myname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(widget.friendName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dummyMessages.length,
              itemBuilder: (BuildContext context, int index) {
                bool isMe =
                    dummyMessages[index]['senderId'] == widget.currentUserId;
                final data = dummyMessages[index];
                return SingleMessage(
                  message: data['message'],
                  date: data['date'],
                  isMe: isMe,
                  friendName: widget.friendName,
                  myName: myname,
                  type: data['type'],
                );
              },
            ),
          ),
          MessageTextField(
            currentId: widget.currentUserId,
            friendId: widget.friendId,
          ),
        ],
      ),
    );
  }
}
