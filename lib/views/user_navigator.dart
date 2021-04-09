import 'package:flutter/material.dart';
import 'package:know_your_medic/views/Chat/chatroomlist.dart';
import 'package:know_your_medic/views/Chat/staff_list.dart';
import 'package:know_your_medic/views/UserPages/user_symptoms_page.dart';
import 'package:know_your_medic/views/UserPages/user_profile_page.dart';
import 'package:page_transition/page_transition.dart';

class UserNavigator extends StatefulWidget {
  @override
  _UserNavigatorState createState() => _UserNavigatorState();
}

class _UserNavigatorState extends State<UserNavigator> {
  PageController pageController = PageController(initialPage: 0);
  List<Widget> pages = [UserSymptomsPage(), UserProfilePage()];
  int _selectedIndex = 0;


  setAppBarTitle(int index) {
    if (index == 0) return Text('Symptoms', style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'Quicksand-Bold',
            fontSize: 24
          ),);
    if (index == 1) return Text('Account', style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'Quicksand-Bold',
            fontSize: 24
          ),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: setAppBarTitle(_selectedIndex),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(context, PageTransition(
                    child: ChatRoomList(),
                    type: PageTransitionType.fade
                  )),
            child: Icon(Icons.chat, color: Theme.of(context).primaryColor,)
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: () {
              Navigator.push(context, PageTransition(
                child: StaffList(),
                type: PageTransitionType.rightToLeftWithFade
              ));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.chat_bubble_outline_outlined, color: Theme.of(context).primaryColor,),
                Positioned(
                  top: 18,
                  child: Icon(Icons.add, size: 16, color: Theme.of(context).primaryColor,)
                ),
              ],          
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),

      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(        
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
            pageController.animateToPage(_selectedIndex,
                duration: Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut);
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.healing,
                color: _selectedIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey[400]),
            // ignore: deprecated_member_use
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded,
                color: _selectedIndex == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey[400]),
            // ignore: deprecated_member_use
            title: Container(),
          ),
        ],
      ),
    );
  }
}