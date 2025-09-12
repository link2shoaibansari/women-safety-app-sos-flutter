import 'package:flutter/material.dart';
import 'package:women_safety_app/chat_module/chat_screen.dart';

import '../../utils/constants.dart';

// Dummy check user status page for UI-only app
class CheckUserStatusBeforeChat extends StatelessWidget {
  const CheckUserStatusBeforeChat({super.key});

  @override
  Widget build(BuildContext context) {
    // Always show ChatPage for dummy UI
    return ChatPage();
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     setState(() {
  //       if (FirebaseAuth.instance.currentUser == null ||
  //           FirebaseAuth.instance.currentUser!.uid.isEmpty) {
  //         if (mounted) {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (_) => LoginScreen()));
  //         }
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addObserver();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        // backgroundColor: Color.fromARGB(255, 250, 163, 192),
        title: Text("SELECT GUARDIAN"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Color.fromARGB(255, 250, 163, 192),
              child: ListTile(
                onTap: () {
                  goTo(
                    context,
                    ChatScreen(
                      currentUserId: 'dummy_user',
                      friendId: 'dummy_friend',
                      friendName: 'Dummy Guardian',
                    ),
                  );
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Dummy Guardian'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
