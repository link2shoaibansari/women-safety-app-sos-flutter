import 'package:flutter/material.dart';
import 'package:women_safety_app/child/bottom_page.dart';
import 'package:women_safety_app/components/PrimaryButton.dart';
import 'package:women_safety_app/components/SecondaryButton.dart';
import 'package:women_safety_app/components/custom_textfield.dart';
import 'package:women_safety_app/child/register_child.dart';
import 'package:women_safety_app/db/share_pref.dart';
import 'package:women_safety_app/parent/parent_register_screen.dart';
import 'package:women_safety_app/utils/constants.dart';
import '../parent/parent_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;
  void _onSubmit() async {
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    // Dummy logic: if email contains 'parent', go to ParentHomeScreen, else BottomPage
    if (_formData['email'] != null &&
        _formData['email'].toString().contains('parent')) {
      MySharedPrefference.saveUserType('parent');
      goTo(context, ParentHomeScreen());
    } else {
      MySharedPrefference.saveUserType('child');
      goTo(context, BottomPage());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            isLoading
                ? progressIndicator(context)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "USER LOGIN",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: kColorRed),
                              ),
                              Image.asset(
                                'assets/logo.png',
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  hintText: 'enter email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.person),
                                  onsave: (email) {
                                    _formData['email'] = email ?? "";
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty ||
                                        email.length < 3 ||
                                        !email.contains("@")) {
                                      return 'enter correct email';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'enter password',
                                  isPassword: isPasswordShown,
                                  prefix: Icon(Icons.vpn_key_rounded),
                                  validate: (password) {
                                    if (password!.isEmpty ||
                                        password.length < 7) {
                                      return 'enter correct password';
                                    }
                                    return null;
                                  },
                                  onsave: (password) {
                                    _formData['password'] = password ?? "";
                                  },
                                  suffix: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordShown = !isPasswordShown;
                                        });
                                      },
                                      icon: isPasswordShown
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility)),
                                ),
                                PrimaryButton(
                                    title: 'LOGIN',
                                    onPressed: () {
                                      // progressIndicator(context);
                                      if (_formKey.currentState!.validate()) {
                                        _onSubmit();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Frogot Password?",
                                style: TextStyle(fontSize: 18),
                              ),
                              SecondaryButton(
                                  title: 'click here', onPressed: () {}),
                            ],
                          ),
                        ),
                        SecondaryButton(
                            title: 'Register as child',
                            onPressed: () {
                              goTo(context, RegisterChildScreen());
                            }),
                        SecondaryButton(
                            title: 'Register as Parent',
                            onPressed: () {
                              goTo(context, RegisterParentScreen());
                            }),
                      ],
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
