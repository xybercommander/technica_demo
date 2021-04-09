import 'package:flutter/material.dart';
import 'package:know_your_medic/modules/user_constants.dart';
import 'package:know_your_medic/services/database.dart';
import 'package:know_your_medic/views/Chat/chat_screen.dart';
import 'package:page_transition/page_transition.dart';

class StaffList extends StatefulWidget {
  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  DatabaseMethods databaseMethods = DatabaseMethods();


  getChatRoomId(String a, String b) {
    if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Consult Medical Experts', style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'Quicksand-Bold',
            fontSize: 24
          ),),
      ),

      body: StreamBuilder(
        stream: databaseMethods.searchStaff(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset('assets/images/noImg.png'),
                      title: Text(snapshot.data.docs[index]['name'], style: TextStyle(fontFamily: 'Quciksand-SemiBold'),),
                      trailing: IconButton(                                              
                        icon: Icon(Icons.chat, color: Theme.of(context).primaryColor,), 
                        onPressed: () {
                          var chatRoomId = getChatRoomId(UserConstants.name, snapshot.data.docs[index]['name']);
                          Map<String, dynamic> chatRoomInfoMap = {
                            'users': [UserConstants.name, snapshot.data.docs[index]['name']]
                          };
                          databaseMethods.createChatRoom(chatRoomId, chatRoomInfoMap);

                          Navigator.pushReplacement(context, PageTransition(
                                child: ChatScreen(snapshot.data.docs[index]['name'], false,),
                                type: PageTransitionType.rightToLeftWithFade
                              ));

                          print('Contacting');
                        },
                      ),
                    ),
                    Divider()
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}