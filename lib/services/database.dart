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

  // adding a message to chats sub-collection of chatrooms collection
  Future addMessage(String chatRoomId, String messageId, Map messageInfoMap) {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .collection('chats')
      .doc(messageId)
      .set(messageInfoMap);
  }

  // Updating the last message sent collections
  updateLastMessageSent(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .update(lastMessageInfoMap);
  }

  // Creating or searching for new or existing chatrooms
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

  // retrieving the chat messages
  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .collection('chats')
      .orderBy('ts', descending: true)
      .snapshots();
  }

  // Getting the list of all the chatrooms created
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