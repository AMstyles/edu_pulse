import 'package:flutter/material.dart';
import '../firebase/auth/auth.dart';
import '../models/local_user.dart';
import 'local_storage_services.dart';

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

  Future<void> signOut()async {
    await Auth.signOut();
    await LocalStorage.removeUserFromLocalStorage();
  }

}