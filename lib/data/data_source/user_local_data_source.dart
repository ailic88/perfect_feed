import 'package:perfect_feed/data/model/user.dart';

const userKey = 'userKey';

class UserLocalDataSource {
  User _user= User();

  UserLocalDataSource();

  User getUser() {
    return _user;
  }

  Future<void> storeUser(User user) async {
    _user = user;
  }
}
