import 'package:flutter/material.dart';
import 'package:know_your_medic/AuthPages/sign_in.dart';
import 'package:know_your_medic/services/auth.dart';
import 'package:page_transition/page_transition.dart';

class StaffHomePage extends StatefulWidget {
  @override
  _StaffHomePageState createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  AuthMethods authMethods = AuthMethods();

  _logout() {
    authMethods.signOut()
      .then((_) {
        Navigator.pushReplacement(context, PageTransition(child: SignIn(), type: PageTransitionType.fade));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Home Page'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              _logout();
              print('Logging out');
            },
            child: Icon(Icons.logout)
          )
        ],
      ),
      body: Center(
        child: Text('Staff'),
      )
    );
  }
}