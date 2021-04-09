import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:know_your_medic/helper/shared_preferences.dart';
import 'package:know_your_medic/modules/staff_constants.dart';
import 'package:know_your_medic/modules/user_constants.dart';
import 'package:know_your_medic/views/Chat/chatroomlist.dart';
import 'package:know_your_medic/views/StaffPages/staff_home_page.dart';
import 'package:know_your_medic/views/user_navigator.dart';
import 'package:page_transition/page_transition.dart';

class AuthChecker extends StatefulWidget {
  final Stream userStream;
  AuthChecker(this.userStream);

  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  DocumentSnapshot documentSnapshot;
  Stream userStream;

  onLogin() {
    setState(() {
      userStream = widget.userStream;
    });
    print('USERSTREAM ----------> $userStream');
  }

  @override
  void initState() {
    onLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: widget.userStream,
        builder: (context, snapshot) {
          // if (snapshot.hasData)
          //   print('DATA IS THERE BRUV');
          // else
          //   print('NO DATA BRUV');
          if(snapshot.hasData) documentSnapshot = snapshot.data.docs[0]; 
          
          if(snapshot.hasData) print('LENGTH --------> ${snapshot.data.docs.length}');         

          Future.delayed(Duration(seconds: 5), () {
            if(documentSnapshot['staff'] == false) {
              UserConstants.email = documentSnapshot['email'];
              UserConstants.name = documentSnapshot['name'];
              UserConstants.imgUrl = documentSnapshot['imgUrl'];

              SharedPref.saveEmailSharedPreference(documentSnapshot['email']);
              SharedPref.saveNameSharedPreference(documentSnapshot['name']);
              SharedPref.saveImgSharedPreference(documentSnapshot['imgUrl']);
              SharedPref.saveLoggedInSharedPreference(true); 
              SharedPref.saveIsStaffSharedPreference(false);  

              Navigator.pushReplacement(context, PageTransition(
                child: UserNavigator(), 
                type: PageTransitionType.fade
              ));
            } else {
              StaffConstants.name = documentSnapshot['name'];
              StaffConstants.email = documentSnapshot['email'];

              SharedPref.saveEmailSharedPreference(documentSnapshot['email']);
              SharedPref.saveNameSharedPreference(documentSnapshot['name']);
              SharedPref.saveLoggedInSharedPreference(true); 
              SharedPref.saveIsStaffSharedPreference(true);

              // TODO: FIX CHATROOM FOR STAFF
              Navigator.pushReplacement(context, PageTransition(
                child: ChatRoomList(), 
                type: PageTransitionType.fade
              ));
            }            
          });

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}