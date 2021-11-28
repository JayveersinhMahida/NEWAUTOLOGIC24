import 'package:autologic/services/auth.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  AuthService().signOut();
                },
                child: Text("signout")),
          ),
        ),
      ),
    );
  }
}
