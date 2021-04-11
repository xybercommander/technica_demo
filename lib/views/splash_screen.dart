import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:technica_know_your_medic/AuthPages/get_started.dart';
import 'package:technica_know_your_medic/helper/shared_preferences.dart';
import 'package:technica_know_your_medic/modules/staff_constants.dart';
import 'package:technica_know_your_medic/modules/user_constants.dart';
import 'package:technica_know_your_medic/services/api.dart';
import 'package:technica_know_your_medic/views/Chat/chatroomlist.dart';
import 'package:technica_know_your_medic/views/user_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  bool isStaff = false;
  MedicApi medicApi = MedicApi();

  saveSymptomsList() async {
    await MedicApi().callSymptomsData();
    print('called function');
  }

  getLogAndStaffState() async {
    bool log = await SharedPref.getUserLoggedInSharedPreference();
    bool staff = await SharedPref.getIsStaffInSharedPreference();

    setState(() {
      if(log == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = log;
      }

      if(staff == null) {
        isStaff = false;
      } else {
        isStaff = staff;
      }
    }); 
  }

  @override
  void initState() {
    getLogAndStaffState();
    saveSymptomsList();

    Future.delayed(Duration(seconds: 4), () async {
      if(isLoggedIn && isStaff == false) {
        UserConstants.email = await SharedPref.getEmailInSharedPreference();
        UserConstants.name = await SharedPref.getNameInSharedPreference();
        UserConstants.imgUrl = await SharedPref.getImgInSharedPreference();        
      } else if(isLoggedIn && isStaff == false) {
        StaffConstants.name = await SharedPref.getNameInSharedPreference();
        StaffConstants.email = await SharedPref.getEmailInSharedPreference();
      }

      // TODO: Fix get started
      Navigator.pushReplacement(context, PageTransition(
        child: !isLoggedIn 
        ? GetStarted() 
        : isStaff 
            ? ChatRoomList() 
            : UserNavigator(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 400)
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hola!',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Lottie.asset('assets/animations/loading-lottie.json', width: 200, height: 200)
          ],
        ),
      ),
    );
  }
}