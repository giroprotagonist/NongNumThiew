import 'package:flutter/material.dart';
import 'package:nongnumtheiw/widgets/show_logo.dart';

Future<Null> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: ShowLogo(),
        title: Text(title),
        subtitle: Text(message),
      ),
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      ],
    ),
  );
}
