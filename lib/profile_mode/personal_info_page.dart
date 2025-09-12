import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  String? profilePic;
  String? downloadUrl;
  bool isSaving = false;
  Future<UserProfile> getUserProfile(String uid) async {
    // Return dummy data for UI-only app
    await Future.delayed(Duration(milliseconds: 50));
    profilePic = null;
    return UserProfile(
      uid: uid,
      name: 'Demo User',
      childemail: 'child@example.com',
      guardiantEmail: 'parent@example.com',
      phone: '1234567890',
      profilePicture: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<UserProfile>(
          future: getUserProfile(
              'qKKpFGFkGFRNRR3zG61ws08oBi22'), // Replace 'user_id' with the actual user ID
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return PersonalInfoPageUi(userProfile: snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget PersonalInfoPageUi({required UserProfile userProfile}) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                // In dummy app, ignore image picking
                setState(() {
                  profilePic = null;
                });
              },
              child: Container(
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 80,
                    child: Center(
                      child: Image.asset(
                        'assets/add_pic.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                '${userProfile.name}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Child Email: ${userProfile.childemail}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Parent Email: ${userProfile.guardiantEmail}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${userProfile.phone}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ));
  }
}

class UserProfile {
  final String uid;
  final String name;
  final String phone;

  final String childemail;
  final String guardiantEmail;

  final String profilePicture;

  UserProfile({
    required this.uid,
    required this.name,
    required this.phone,
    required this.childemail,
    required this.guardiantEmail,
    required this.profilePicture,
  });
}
