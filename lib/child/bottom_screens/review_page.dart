import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_app/components/PrimaryButton.dart';
import 'package:women_safety_app/components/custom_textfield.dart';
import 'package:women_safety_app/utils/constants.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController locationC = TextEditingController();
  TextEditingController viewsC = TextEditingController();
  bool isSaving = false;
  double? ratings;
  // Dummy review list for UI-only
  List<Map<String, dynamic>> dummyReviews = [
    {
      'location': 'Central Park',
      'views': 'Safe and well-lit.',
      'ratings': 4.0,
    },
    {
      'location': 'Main Street',
      'views': 'Crowded but safe.',
      'ratings': 3.5,
    },
  ];

  showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(2.0),
            title: Text("Review your place"),
            content: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'enter location',
                    controller: locationC,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: viewsC,
                    hintText: 'enter location',
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (star) {
                    return IconButton(
                      icon: Icon(
                        Icons.star,
                        color: star < (ratings ?? 1.0).round()
                            ? kColorDarkRed
                            : Colors.grey.shade300,
                      ),
                      onPressed: () {
                        setState(() {
                          ratings = (star + 1).toDouble();
                        });
                      },
                    );
                  }),
                ),
              ],
            )),
            actions: [
              PrimaryButton(
                  title: "SAVE",
                  onPressed: () {
                    saveReview();
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  void saveReview() async {
    setState(() {
      isSaving = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    dummyReviews.add({
      'location': locationC.text,
      'views': viewsC.text,
      'ratings': ratings ?? 1.0,
    });
    setState(() {
      isSaving = false;
      Fluttertoast.showToast(msg: 'review uploaded (dummy)');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSaving == true
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Recent Review by other",
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: dummyReviews.length,
                      itemBuilder: (context, index) {
                        final data = dummyReviews[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Location : ${data['location']}",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  Text(
                                    "Comments : ${data['views']}",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(5, (star) {
                                      double rating = data['ratings'] ?? 1.0;
                                      return Icon(
                                        Icons.star,
                                        color: star < rating.round()
                                            ? kColorDarkRed
                                            : Colors.grey.shade300,
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          showAlert(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
