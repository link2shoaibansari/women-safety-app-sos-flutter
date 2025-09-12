import 'package:flutter/material.dart';
import 'package:women_safety_app/chat_module/chat_screen.dart';
import 'package:women_safety_app/utils/constants.dart';

import '../child/child_login_screen.dart';

class ParentHomeScreen extends StatelessWidget {
  // Dummy child list for UI-only
  final List<Map<String, String>> dummyChildren = [
    {'id': 'child1', 'name': 'Alice'},
    {'id': 'child2', 'name': 'Bob'},
    {'id': 'child3', 'name': 'Charlie'},
  ];
  ParentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(),
            ),
            ListTile(
                title: TextButton(
                    onPressed: () {
                      // Dummy sign out: just go to login
                      goTo(context, LoginScreen());
                    },
                    child: Text(
                      "SIGN OUT",
                    ))),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        // backgroundColor: Color.fromARGB(255, 250, 163, 192),
        title: Text("SELECT CHILD"),
      ),
      body: ListView.builder(
        itemCount: dummyChildren.length,
        itemBuilder: (BuildContext context, int index) {
          final d = dummyChildren[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Color.fromARGB(255, 250, 163, 192),
              child: ListTile(
                onTap: () {
                  // Dummy: use fixed currentUserId
                  goTo(
                    context,
                    ChatScreen(
                      currentUserId: 'parent1',
                      friendId: d['id']!,
                      friendName: d['name']!,
                    ),
                  );
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(d['name']!),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
