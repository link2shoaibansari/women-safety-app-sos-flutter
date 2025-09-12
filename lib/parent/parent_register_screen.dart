import 'package:flutter/material.dart';

class RegisterParentScreen extends StatefulWidget {
  @override
  State<RegisterParentScreen> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParentScreen> {
  @override
  Widget build(BuildContext context) {
    // Dummy UI for parent registration
    return Scaffold(
      appBar: AppBar(title: Text('Register Parent')),
      body: Center(child: Text('Parent Registration UI Placeholder')),
    );
  }
}
