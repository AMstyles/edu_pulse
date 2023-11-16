import 'package:flutter/material.dart';
import '../firebase/auth/auth.dart';
import '../models/local_user.dart';

class UserProvider extends ChangeNotifier{
  LocalUser? _user = LocalUser(name: 'test', email: 'email@example.com', isStudent: false, faculty: 'test');

  Future<LocalUser>? userFuture;

  LocalUser? get user => _user;


  void setUser(LocalUser user){
    _user = user;
    notifyListeners();
  }


  void setUserFuture(Future<LocalUser> userFuture){
    this.userFuture = userFuture;
    notifyListeners();
  }

  void signOut()async {
    await Auth.signOut();
  }

}