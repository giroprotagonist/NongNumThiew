import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildCreateNewAccount(context),
      ),
    );
  }

  Column buildCreateNewAccount(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Non Account ? '),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, '/createAccount'),
                child: Text('Create New Account'))
          ],
        ),
      ],
    );
  }
}
