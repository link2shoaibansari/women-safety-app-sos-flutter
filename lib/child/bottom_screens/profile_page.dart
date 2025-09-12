import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:women_safety_app/child/bottom_page.dart';
import 'package:women_safety_app/components/PrimaryButton.dart';
import 'package:women_safety_app/components/custom_textfield.dart';
import 'package:women_safety_app/utils/constants.dart';

// Dummy wrapper for UI-only app, always shows ProfilePage
class CheckUserStatusBeforeChatOnProfile extends StatelessWidget {
  const CheckUserStatusBeforeChatOnProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePage();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController guardianEmailC = TextEditingController();
  TextEditingController childEmailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  final key = GlobalKey<FormState>();
  String? id;
  String? profilePic;
  String? downloadUrl;
  bool isSaving = false;

  // Dummy: populate with static data for UI-only
  void getDate() {
    setState(() {
      nameC.text = 'Jane Doe';
      childEmailC.text = 'child@email.com';
      guardianEmailC.text = 'parent@email.com';
      phoneC.text = '1234567890';
      id = 'dummy_id';
      profilePic = null;
    });
  }

  @override
  void initState() {
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isSaving == true
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.pink,
            ))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Form(
                      key: key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "UPDATE YOUR PROFILE",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () async {
                              final XFile? pickImage = await ImagePicker()
                                  .pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 50);
                              if (pickImage != null) {
                                setState(() {
                                  profilePic = pickImage.path;
                                });
                              }
                            },
                            child: Container(
                              child: profilePic == null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.deepPurple,
                                      radius: 80,
                                      child: Center(
                                          child: Image.asset(
                                        'assets/add_pic.png',
                                        height: 80,
                                        width: 80,
                                      )),
                                    )
                                  : profilePic!.contains('http')
                                      ? CircleAvatar(
                                          backgroundColor: Colors.deepPurple,
                                          radius: 80,
                                          backgroundImage:
                                              NetworkImage(profilePic!),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.deepPurple,
                                          radius: 80,
                                          backgroundImage:
                                              FileImage(File(profilePic!))),
                            ),
                          ),
                          CustomTextField(
                            controller: nameC,
                            hintText: nameC.text,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return 'please enter your updated name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: childEmailC,
                            hintText: "child email",
                            readOnly: true,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return 'please enter your updated name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: guardianEmailC,
                            hintText: "parent email",
                            readOnly: true,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return 'please enter your updated name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: phoneC,
                            hintText: "Phone number",
                            readOnly: true,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return 'please enter your updated name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
                          PrimaryButton(
                              title: "UPDATE",
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                  profilePic == null
                                      ? Fluttertoast.showToast(
                                          msg: 'please select profile picture')
                                      : update();
                                }
                              })
                        ],
                      )),
                ),
              ),
            ),
    );
  }

  // Dummy: just return the file path for UI-only
  Future<String?> uploadImage(String filePath) async {
    return filePath;
  }

  // Dummy: just show a toast and go to BottomPage
  void update() async {
    setState(() {
      isSaving = true;
    });
    await Future.delayed(Duration(seconds: 1));
    Fluttertoast.showToast(msg: 'Profile updated (dummy)');
    setState(() {
      isSaving = false;
      goTo(context, BottomPage());
    });
  }
}
