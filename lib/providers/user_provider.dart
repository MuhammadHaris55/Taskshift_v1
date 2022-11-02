import 'package:flutter/cupertino.dart';
import '../models/User.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: 0,
    firstName: '',
    lastName: '',
    userName: '',
    displayName: '',
    email: '',
    remainingBids: 0,
    apiToken: '',
    profileviewas: '',
    image: '',
    alphabeticImage: '',
    identityVerify: 0,
    contactVerify: '',
    skills: [],
    // id: '',
    // name: '',
    // email: '',
    // password: '',
    // address: '',
    // type: '',
    // token: '',
    // cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
