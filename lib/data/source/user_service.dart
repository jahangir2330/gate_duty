import 'package:gipms/domain/entities/user_entity.dart';

class UserService {
  UserService._();
  static final UserService _instance = UserService._();
  factory UserService() => _instance;

  UserEntity? _currentUser;

  UserEntity? get currentUser => _currentUser;

  void setUser(UserEntity? user) {
    _currentUser = user;
  }

  void clearUser() {
    _currentUser = null;
  }
}
