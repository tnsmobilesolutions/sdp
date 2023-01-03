import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp/Models/userDetailsModel.dart';

class UserAPI {
  //SignIn

  Future<UserDetailsModel?> signIn(String email, String password) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => uid);

      final currentUserId = userCredential?.user?.uid;
      final userDetails = await usersCollection
          .where("uid", isEqualTo: currentUserId)
          .get()
          .then(
        (querySnapshot) {
          final userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          final user = UserDetailsModel.fromMap(userData);
          return user;
        },
      );
      return userDetails;

      //return uid.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return null;
      } else if (e.code == 'wrong-password') {
        return null;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<UserDetailsModel?> getCurrentUserData() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final currentuid = await FirebaseAuth.instance.currentUser?.uid;
    final data =
        await usersCollection.where('uid', isEqualTo: currentuid).get().then(
      (querySnapshot) {
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        final user = UserDetailsModel.fromMap(userData);
        return user;
      },
    );
    return data;
  }

//Logout
  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); //
    }
  }

  // creat docID
  Future<int> countUsers() async {
    CollectionReference usercollection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot _myDoc = await usercollection.get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;

    return _myDocCount.length; // Count of Documents in Collection
  }
}
