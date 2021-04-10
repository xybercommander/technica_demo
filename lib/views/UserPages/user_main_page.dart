import 'package:flutter/material.dart';

class UserMainPage extends StatefulWidget {
  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Symptoms Page', style: TextStyle(fontFamily: 'Quicksand-SemiBold', fontSize: 20),),
      ),
    );
  }
}