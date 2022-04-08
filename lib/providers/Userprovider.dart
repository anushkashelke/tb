import 'package:flutter/widgets.dart';
import 'package:timbrebells/models/users.dart';
import 'package:timbrebells/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User_details? _user; //User_details from users.dart
  //_user=private variable
  final auth_methods _authMethods = auth_methods(); //auth_methods class from auth_method.dart

  User_details get getUser => _user!; //get is used to retrieve a particular class field and save it in a variable

  Future<void> refreshUser() async { //Future class is used when we aren't sure if a function can be used in a future or not
    //it will be used according to the choice of user
    User_details user = await _authMethods.getUserDetails() ;//getUserDetails is a function in users.dart which returns all info as snapshot
    //of current user
    _user = user;
    notifyListeners(); //to notify everyone that the data of current user has changed
  }
}