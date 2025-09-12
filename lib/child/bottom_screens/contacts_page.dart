import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<Map<String, String>> dummyContacts = [
    {'name': 'Alice', 'phone': '1234567890'},
    {'name': 'Bob', 'phone': '9876543210'},
    {'name': 'Charlie', 'phone': '5555555555'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: dummyContacts.length,
        itemBuilder: (context, index) {
          final contact = dummyContacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Text(contact['name']![0]),
            ),
            title: Text(contact['name']!),
            subtitle: Text(contact['phone']!),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped ${contact['name']}')),
              );
            },
          );
        },
      ),
    );
  }
}
