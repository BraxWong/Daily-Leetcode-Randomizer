import 'package:flutter/material.dart';
class PopUpWindow {
  Future<void> showPopUpWindow(required String title, required String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuilderContext context) {
        return AlertDialog(
          title: const Text(title),
          content: const SinglChildScrollView(
            child: ListBody(
              children: <Widget> [
                Text(message)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
