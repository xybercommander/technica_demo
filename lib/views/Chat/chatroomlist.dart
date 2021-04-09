import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:know_your_medic/AuthPages/sign_in.dart';
import 'package:know_your_medic/helper/shared_preferences.dart';
import 'package:know_your_medic/modules/encryption_constants.dart';
import 'package:know_your_medic/services/auth.dart';
import 'package:know_your_medic/services/database.dart';
import 'package:know_your_medic/widgets/chat_widgets.dart';
import 'package:page_transition/page_transition.dart';

class ChatRoomList extends StatefulWidget {
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  AuthMethods authMethods = AuthMethods();
  Stream chatRoomsStream;
  bool isStaff;
  final encrypter = Encrypter(AES(EncryptionConstants.encryptionKey));


  getIsCompany() async {
    isStaff = await SharedPref.getIsStaffInSharedPreference();
  }

  getChatRooms() async {
    chatRoomsStream = await databaseMethods.getChatRooms(isStaff);
    setState(() {});
  }  

  onScreenLoaded() async {
    await getIsCompany();
    getChatRooms();
  }


  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {        
        return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.only(top: 24),       
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            // return Text(ds.id.replaceAll(CustomerConstants.fullName, '').replaceAll('_', ''));
            String message = encrypter.decrypt64(ds['lastMessage'], iv: EncryptionConstants.iv);
            return ChatRoomListTile(ds.id, message, isStaff);
          },
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(':(', style: TextStyle(fontSize: 50),),
              SizedBox(height: 20,),
              Text('Seems empty')
            ],
          ),
        );
      },
    );
  }


  logout() {
    authMethods.signOut()
      .then((_) {
        Navigator.pushReplacement(context, PageTransition(child: SignIn(), type: PageTransitionType.fade));
      });
  }


  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text('Chatroom List Page', style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'Quicksand-Bold',
            fontSize: 24
          ),),
        actions: [
          isStaff ? IconButton(
            icon: Icon(Icons.logout, color: Theme.of(context).primaryColor,),
            onPressed: () {
              logout();
              print('Logging out');
            },
          ) : Container()
        ],
      ),

      body: chatRoomsList()
    );
  }
}