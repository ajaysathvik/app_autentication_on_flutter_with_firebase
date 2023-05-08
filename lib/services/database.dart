import 'package:cloud_firestore/cloud_firestore.dart';

class Databaseservice{
  final String? uid;
  Databaseservice({this.uid});

  //reference for collections
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("group");

  //saving the user data
  Future savingTheUserData (String fullName,String email)async{
    return await userCollection.doc(uid).set({
      "fullname":fullName,
      "email":email,
      "groups":[],
      "profilePic":"",
      "uid":uid
    });
  }

    //getting the user data
  Future gettingUserData(String email) async{
    QuerySnapshot snapshot = await userCollection.where("email",isEqualTo:email).get();
    return snapshot;
  }
}