import 'dart:math';
import 'package:clippy_flutter/paralellogram.dart';
import 'package:flutter/material.dart';
import 'package:know_your_medic/AuthPages/sign_in.dart';
import 'package:page_transition/page_transition.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(         
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,              
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 150,
                    child: Transform.rotate(
                      angle: -pi / 11,
                      child: Parallelogram(
                        cutLength: 30.0,
                        edge: Edge.RIGHT,
                        child: Container(
                          color: Color(0xffb12341),
                          width: MediaQuery.of(context).size.width - 50,
                          height: 100.0,                
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 1,                    
                    child: Image.asset('assets/images/doctor.png', height: 350,)
                  ),
                  Transform.rotate(
                    angle: -pi / 11,
                    child: Parallelogram(
                      cutLength: 30.0,
                      edge: Edge.RIGHT,
                      child: Container(
                        color: Color(0xff99d5f3),
                        width: MediaQuery.of(context).size.width - 100,
                        height: 100.0,                
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: MediaQuery.of(context).size.height / 2 - 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get Started', 
                    style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Helping thousands of people to consult the right Physician', 
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Quicksand-Bold',),                  
                  ),
                  SizedBox(height: 20,),
                  Hero(
                    tag: 'button-red',
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () => Navigator.pushReplacement(context, PageTransition(
                        child: SignIn(),
                        type: PageTransitionType.fade,                        
                      )),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,                             
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                      height: 45,
                      minWidth: 100,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}