import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Dummy implementations for location/SMS in dummy app
import 'package:women_safety_app/db/db_services.dart';
import 'package:women_safety_app/model/contactsm.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  // For the dummy app we keep simple fields and no real location/SMS calls.
  String? _curentAddress = "Unknown location";

  _isPermissionGranted() async => true;
  _sendSms(String phoneNumber, String message) async {
    // no-op in dummy
    Fluttertoast.showToast(msg: "(Dummy) message prepared for $phoneNumber");
  }

  _getCurrentLocation() async {
    // set a dummy address
    setState(() {
      _curentAddress = "123 Demo Street, Demo City";
    });
  }

  @override
  void initState() {
    super.initState();
    // initialize dummy state
    _getCurrentLocation();
  }

  showModelSafeHome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.4,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SEND YOUR CUURENT LOCATION IMMEDIATELY TO YOU EMERGENCY CONTACTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                if (_curentAddress != null) Text(_curentAddress!),
                PrimaryButton(
                    title: "GET LOCATION",
                    onPressed: () {
                      _getCurrentLocation();
                    }),
                SizedBox(height: 10),
                PrimaryButton(
                    title: "SEND ALERT",
                    onPressed: () async {
                      List<TContact> contactList =
                          await DatabaseHelper().getContactList();
                      print(contactList.length);
                      if (contactList.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "emergency contact is empty");
                      } else {
                        String messageBody =
                            "(Dummy) My location: $_curentAddress";

                        if (await _isPermissionGranted()) {
                          contactList.forEach((element) {
                            _sendSms("${element.number}",
                                "i am in trouble $messageBody");
                          });
                        } else {
                          Fluttertoast.showToast(msg: "something wrong");
                        }
                      }
                    }),
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModelSafeHome(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  ListTile(
                    title: Text("Send Location"),
                    subtitle: Text("Share Location"),
                  ),
                ],
              )),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/route.jpg')),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool loading;
  PrimaryButton(
      {required this.title, required this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
