import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:know_your_medic/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
        primaryColor: Color(0xffb12341),
        fontFamily: 'Quicksand',        
      ),
      home: SplashScreen(),
    );
  }
}