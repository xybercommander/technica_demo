import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technica_know_your_medic/modules/staff_constants.dart';
import 'package:technica_know_your_medic/modules/user_constants.dart';

class DatabaseMethods {

  // ---------SIGN UP INFO UPLOAD METHOD--------- //
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  // ---------SIGN IN INFO GET METHOD--------- //
  Future<Stream<QuerySnapshot>> getUserInfoByEmail(String userEmail) async {
    return FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: userEmail)
      .snapshots();
  }

  // -----------METHOD TO PRINT GET THE LIST OF STAFF----------- //
  searchStaff() {
    return FirebaseFirestore.instance.collection('users')
      .where('staff', isEqualTo: true)
      .snapshots();
  }

  // ------------ADDING MESSAGES TO CHATROOMS COLLECTION------------ //
  Future addMessage(String chatRoomId, String messageId, Map messageInfoMap) {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .collection('chats')
      .doc(messageId)
      .set(messageInfoMap);
  }

  // ------------UPDATING THE LAST MESSAGE IN CHATROOMS------------ //
  updateLastMessageSent(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .update(lastMessageInfoMap);
  }

  // ------------CREATING OR SEARCHING FOR EXISTING CHATROOMS------------ //
  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .get();

    if(snapshot.exists) {
      // if chatroom exists
      return true;
    } else {
      // if chatroom does not exist
      return FirebaseFirestore.instance.collection('chatrooms')
        .doc(chatRoomId)
        .set(chatRoomInfoMap);
    }
  }

  // ------------RETRIEVING THE CHAT MESSAGES------------ //
  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .collection('chats')
      .orderBy('ts', descending: true)
      .snapshots();
  }

  // ------------GETTING THE LIST OF ALL THE CHATROOMS------------ //
  Future<Stream<QuerySnapshot>> getChatRooms(isStaff) async {
    String name;
    if(isStaff) {
      name = StaffConstants.name;
    } else {
      name = UserConstants.name;
    }

    return FirebaseFirestore.instance.collection('chatrooms')
      .orderBy('lastMessageSentTs', descending: true)
      .where('users', arrayContains: name)
      .snapshots();
  }


}