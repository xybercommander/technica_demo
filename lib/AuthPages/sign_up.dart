import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:know_your_medic/AuthPages/sign_in.dart';
import 'package:know_your_medic/helper/shared_preferences.dart';
import 'package:know_your_medic/services/database.dart';
import 'package:know_your_medic/modules/user_constants.dart';
import 'package:know_your_medic/services/auth.dart';
import 'package:know_your_medic/views/user_navigator.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();

  bool showPassword = false;  
  final picker = ImagePicker();
  File _image;
  String imgUrl = '';

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  // --------------SIGN UP METHOD-------------- //
  _signUp() async {
    if(_formKey.currentState.validate()) {
      if(_image != null) {
        await uploadPic();
      }

      Map<String, dynamic> userInfo = {
        'name': _nameTextEditingController.text,
        'email': _emailTextEditingController.text,
        'imgUrl': imgUrl != null ? imgUrl : '',
        'staff': false
      };

      SharedPref.saveNameSharedPreference(_nameTextEditingController.text);
      SharedPref.saveEmailSharedPreference(_emailTextEditingController.text);
      SharedPref.saveImgSharedPreference(imgUrl);
      SharedPref.saveLoggedInSharedPreference(true); 
      SharedPref.saveIsStaffSharedPreference(false);         

      authMethods.signUpWithEmailAndPassword(_emailTextEditingController.text, _passwordTextEditingController.text)
        .then((_) {
          UserConstants.email = _emailTextEditingController.text;
          UserConstants.name = _nameTextEditingController.text;   
          UserConstants.imgUrl = imgUrl;       

          databaseMethods.uploadUserInfo(userInfo);

          Navigator.pushReplacement(context, PageTransition(
            child: UserNavigator(),
            type: PageTransitionType.rightToLeftWithFade
          ));
        });

    }
  }


  // -----------IMAGE PICKER METHOD----------- //
  Future getImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(
            msg: 'No Image Picked!',
            textColor: Colors.white,
            backgroundColor: Color.fromRGBO(253, 170, 142, 1));
      }      
    });
  }

  // ----------UPLOADING THE IMAGE IN FIREBASE STORAGE---------- //
  Future uploadPic() async {
    final file = _image;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child(file.path);
    await reference.putFile(file);
    imgUrl = await reference.getDownloadURL();
  }



  // -------------UI------------- //
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
              'Hi!\nLet\'s get Started!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontFamily: 'Quicksand-Bold'
              ),
            ),
            Text(
              'Create an account',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontFamily: 'Quicksand-SemiBold'
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: _image == null ? 
                      AssetImage('assets/images/noImg.png') :
                      FileImage(_image),
                  backgroundColor: Colors.transparent,
                  radius: 50,
                ),
                // ignore: deprecated_member_use
                FlatButton(                  
                  onPressed: () async {
                    await getImage();
                  },
                  child: Text(
                    'Add Image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,                             
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  height: 40,
                  minWidth: 80,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                children: [

                  // ---------NAME FIELD--------- //
                  Container(   
                    padding: EdgeInsets.symmetric(horizontal: 16),                   
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: TextFormField(
                      controller: _nameTextEditingController,
                      style: TextStyle(fontFamily: 'Quicksand-SemiBold', color: Colors.grey[800]),
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(fontFamily: 'Quicksand-SemiBold', color: Colors.grey[400]),                          
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

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
                        _signUp();
                        print('Signing up');
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
                              'Sign Up',
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
                        child: SignIn(),
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
                          'Login',
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