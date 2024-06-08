import 'package:flutter/material.dart';

/* ----------------------------------------------------------------------------------------------------------------
 * @Disclaimer: The following class is derived from https://api.flutter.dev/flutter/material/AlertDialog-class.html
 *              For more information, please visit the official flutter website for the original implementation
 * @Class: PopUpWindow
 * @Param: BuildContext context -> Allows the pop up window to be displayed in the current page
 *         String title         -> The title of the pop up window
 *         String message       -> The message of the pop up window
 * @Description: The PopUpWindow class is used to display a pop up winodw / dialog in front of the current screen.
 */

class PopUpWindow {
  Future<void> showPopUpWindow(BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
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
