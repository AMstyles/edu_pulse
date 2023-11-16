import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/local_user.dart';

class Database {

  static final _storage = FirebaseFirestore.instance;

  static Future<void> writeUser(LocalUser user, BuildContext context) async {
    //show loading dialog
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: const Text('Loading'),
          content: const Text('Please wait while we set everything up for you'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child:const Text('Ok'))
          ],));

    try {
      final something = await _storage.collection('users').doc(user.email).set(user.toJson());
      Navigator.pop(context);
    }
    on FirebaseException catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text('Error'),
            content: Text(e.message!),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('Ok'))
            ],));
    }
  }

  static Future<LocalUser> getUserFromFirestore(
      String id, BuildContext context) async {
    try {
      late final LocalUser newUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        newUser = LocalUser.fromJson(value.data()!);
      });

      //await LocalStorage.writeUserToLocalStorage(newUser);

      // Provider.of<UserProvider>(context, listen: false).setUser(newUser);

      return newUser;
    } catch (e) {
      if (kDebugMode) {
        print('Error' + e.toString());
      }
      return LocalUser(
          name: '',
          email: '',
            isStudent: false, faculty: '');
    }
  }

  static Future<LocalUser> getUser(String id) {
    return _storage
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      if (value.data() == null) {
        print ('User not found');
      }
      else{
        print('User found');
      }
      return LocalUser.fromJson(value.data()!);
    });
  }

  static  Future<bool> deleteUserData(String email)async{
    //do magic
    _storage.collection('users').doc('$email').delete();
    return true;
  }

}