import 'dart:math';

import 'package:perfect_feed/data/data_source/feeds_remote_data_source.dart';
import 'package:perfect_feed/data/model/feed.dart';
import 'package:perfect_feed/data/model/user.dart';

class FeedsRepository {
  final FeedsRemoteDataSource _feedsRemoteDataSource;

  FeedsRepository(this._feedsRemoteDataSource);

  Future<List<Feed>> getFeeds(User user) async {
    return _feedsRemoteDataSource.getFeeds(user);
  }

  void reset() => _feedsRemoteDataSource.reset();
}
