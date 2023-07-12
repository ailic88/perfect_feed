import 'package:perfect_feed/data/data_source/user_local_data_source.dart';
import 'package:perfect_feed/data/model/user.dart';

class UserRepository {
  final UserLocalDataSource _userLocalDataSource;

  UserRepository(this._userLocalDataSource);

  User getUser() => _userLocalDataSource.getUser();

  Future<void> storeUser(User user) => _userLocalDataSource.storeUser(user);
}
