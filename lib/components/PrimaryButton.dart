import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool loading;
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: kColorRed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
