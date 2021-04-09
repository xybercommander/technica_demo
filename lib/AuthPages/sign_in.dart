import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:know_your_medic/AuthPages/auth_checker.dart';
import 'package:know_your_medic/AuthPages/sign_up.dart';
import 'package:know_your_medic/services/database.dart';
import 'package:know_your_medic/services/auth.dart';
import 'package:page_transition/page_transition.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();

  bool showPassword = false;
  Stream<QuerySnapshot> userStream;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  onLogin() async {
    userStream = await databaseMethods.getUserInfoByEmail(_emailTextEditingController.text);    
  }


  _signIn() async {
    await onLogin();

    authMethods.signInWithEmailAndPassword(_emailTextEditingController.text, _passwordTextEditingController.text)
      .then((_) {
        Navigator.pushReplacement(
          context, 
          PageTransition(child: AuthChecker(userStream), type: PageTransitionType.rightToLeftWithFade)
        );
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Hey!\nWelcome back!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontFamily: 'Quicksand-Bold'
              ),
            ),
            Text(
              'Login to your account',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontFamily: 'Quicksand-SemiBold'
              ),
            ),
            Spacer(),
            Form(
              key: _formKey,
              child: Column(
                children: [

                  // ---------EMAIL FIELD--------- //
                  Container(   
                    padding: EdgeInsets.symmetric(horizontal: 16),                   
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: TextFormField(
                      controller: _emailTextEditingController,
                      style: TextStyle(fontFamily: 'Quicksand-SemiBold', color: Colors.grey[800]),
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(fontFamily: 'Quicksand-SemiBold', color: Colors.grey[400]),                          
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  // ---------PASSWORD FIELD--------- //
                  Container(                  
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2), 
                    height: 50,    
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: TextFormField(                        
                      controller: _passwordTextEditingController,                        
                      style: TextStyle(fontFamily: 'Quicksand-SemiBold', color: Colors.grey[800]),
                      cursorColor: Colors.grey,                        
                      obscureText: showPassword ? false : true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(fontFamily: 'Quicksand-SemiBold', color: Colors.grey[400]),                          
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                            print(showPassword);
                          },
                          child: Icon(showPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey[700],),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Hero(
                    tag: 'button-red',
                    child: GestureDetector(
                      onTap: () {
                        _signIn();
                        print('Signing in');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Quicksand-Bold',
                                fontSize: 24
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, PageTransition(
                        child: SignUp(),
                        type: PageTransitionType.fade
                    )),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'Quicksand-Bold',
                            fontSize: 24
                          ),
                        ),
                      ),
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