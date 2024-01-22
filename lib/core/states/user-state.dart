import 'package:advanced_mobile_project/core/dtos/user-dto.dart';
import 'package:advanced_mobile_project/core/models/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  UserDTO? userDTO;
  bool isLoading = false;

  void setUser(User? user) {
    this.user = user;
    notifyListeners();
  }

  void setUserDTO(UserDTO? userDTO) {
    this.userDTO = userDTO;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
}
