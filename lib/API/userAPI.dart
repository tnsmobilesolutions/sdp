import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp/Models/userModel.dart';

class UserAPI {
  String? currentUserId = '';
  //SignIn
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<userDetailsModel?> signIn(String email, String password) async {
    final CollectionReference vendorsCollection =
        FirebaseFirestore.instance.collection('vendors');
    UserCredential? userCredential;
    try {
      userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => uid);
      print('***********uid: ${userCredential?.user?.uid}*********');
      currentUserId = userCredential?.user?.uid;
      final user = vendorsCollection
          .where("FirebaseUID", isEqualTo: currentUserId)
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final userData =
                querySnapshot.docs.first.data() as Map<String, dynamic>;
            final user = userDetailsModel.fromMap(userData);
            return user;
          } else {
            return null;
          }
        },
      );
      return user;

      //return uid.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        //print('Wrong password provided for that user.');
        return null;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<String?> getCurrentUserData() async {
    final CollectionReference vendorsCollection =
        FirebaseFirestore.instance.collection('vendors');
    vendorsCollection.where('FirebaseUID', isEqualTo: currentUserId).get().then(
      (querySnapshot) {
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        print('vendor Id - ${userData.entries.last}');
      },
    );
    return null;

    // final vendorDetails = await _vendorsCollection.doc(userId).get().then(
    //   (querySnapshot) {
    //     final userData = querySnapshot.data() as Map<String, dynamic>;
    //     final vendorData = UserModel.fromMap(userData);
    //     return vendorData;
    //   },
    // );

    // return vendorDetails;
  }

//Logout
  logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e); //
    }
  }

  //VendorId $ VenderName
  Future<String?> currentUserName() async {
    final CollectionReference vendorsCollection =
        FirebaseFirestore.instance.collection('vendors');
    try {
      String? currentUID = _auth.currentUser?.uid;

      final user = vendorsCollection
          .where("FirebaseUID", isEqualTo: currentUID)
          .get()
          .then(
        (querySnapshot) {
          final userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          String name = userData['name'];
          log(name);
          return name;

          // _loggedInUser = user;
        },
      );
      return user;

      //return uid.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}

class userModel {}
