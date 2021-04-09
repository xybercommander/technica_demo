import 'package:flutter/material.dart';
import 'package:know_your_medic/modules/staff_constants.dart';
import 'package:know_your_medic/modules/user_constants.dart';
import 'package:know_your_medic/views/Chat/chat_screen.dart';
import 'package:page_transition/page_transition.dart';

class ChatRoomListTile extends StatefulWidget {
  final String chatRoomId;
  final String lastMessage;
  final bool isStaff;
  ChatRoomListTile(this.chatRoomId, this.lastMessage, this.isStaff);
  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String name = '';
  var names = [];


  getThisUserName() async {    
    names = widget.chatRoomId.split('_');
    if(!widget.isStaff) {
      int i = names.indexOf(UserConstants.name);
      i == 0 ? name = names[1] : name = names[0];
    } else {
      int i = names.indexOf(StaffConstants.name);
      i == 0 ? name = names[1] : name = names[0];
    }
    setState(() {});
  }

  @override
  void initState() {
    getThisUserName();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, PageTransition(
        child: ChatScreen(name, widget.isStaff),
        type: PageTransitionType.rightToLeftWithFade
      )),
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [                        
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/noImg.png'),
              backgroundColor: Colors.white,
              radius: 20,
            ),
            SizedBox(width: 20,),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [            
                  Text(name, style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Quicksand-SemiBold'
                  ),),
                  Text(
                    widget.lastMessage.length > 30 ? widget.lastMessage.substring(0, 30) + '...' : widget.lastMessage, 
                    overflow: TextOverflow.ellipsis, 
                    style: TextStyle(
                    fontSize: 13,
                    color: Colors.white54,
                    fontFamily: 'Quicksand-SemiBold'
                  ),)
                ],
              ),
          ],
        ),
      ),
    );
  }
}