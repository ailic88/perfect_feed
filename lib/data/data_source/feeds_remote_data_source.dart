import 'dart:math';

import 'package:geolocator/geolocator.dart' hide ActivityType;
import 'package:perfect_feed/core/const.dart';
import 'package:perfect_feed/data/model/feed.dart';
import 'package:perfect_feed/data/model/user.dart';

class FeedsRemoteDataSource {
  List<Feed> _allFeeds;
  List<int> _seenFeeds;

  FeedsRemoteDataSource()
      : _allFeeds = generateFeeds(),
        _seenFeeds = List.empty(growable: true);

  void reset() {
    _allFeeds = generateFeeds();
    _seenFeeds = List.empty(growable: true);
  }

  Future<List<Feed>> getFeeds(User user) async {
    final List<Feed> _unseenInRadiusFeeds = _allFeeds.where((element) {
      if (_seenFeeds.contains(element.id)) {
        return false;
      }
      double distanceInMeters = Geolocator.distanceBetween(
        user.userLocation.latitude,
        user.userLocation.longitude,
        element.activityLocation.latitude,
        element.activityLocation.longitude,
      );
      return distanceInMeters / 1000 < user.radiusInKm;
    }).toList();

    final List<Feed> newFeeds = List.empty(growable: true);
    if (user.preferedActivity.isEmpty) {
      newFeeds.addAll(_unseenInRadiusFeeds.take(feedsChunkSize).toList());
    } else {
      newFeeds.addAll(
        _unseenInRadiusFeeds
            .where((element) => user.preferedActivity.contains(element.activityType))
            .take(feedsChunkSize)
            .toList(),
      );
      if (newFeeds.length < feedsChunkSize) {
        newFeeds.addAll(
          _unseenInRadiusFeeds
              .where((element) => !user.preferedActivity.contains(element.activityType))
              .take(feedsChunkSize - newFeeds.length)
              .toList(),
        );
      }
    }
    _seenFeeds.addAll(newFeeds.map((e) => e.id));
    return newFeeds;
  }
}

List<Feed> generateFeeds() {
  final List<Feed> feeds = List.empty(growable: true);
  final random = Random();

  List<Location> randomLocationsInRadius = generateRandomLocationInRadius(feedCount);

  for (int i = 0; i < feedCount; i++) {
    int activityTypeIndex = random.nextInt(6);
    feeds.add(
      Feed(
        id: i,
        activityType: ActivityTypeEnum.values[activityTypeIndex],
        title: 'Title $i',
        activityLocation: randomLocationsInRadius[i],
      ),
    );
  }
  return feeds;
}

List<Location> generateRandomLocationInRadius(int numberOfPoints) {
  List<Location> activityLocations = [];

  const double radiusInDegrees = maxRadiusInKm / 111;

  for (int i = 0; i < numberOfPoints; i++) {
    final double u = Random().nextDouble();
    final double v = Random().nextDouble();
    final double w = radiusInDegrees * sqrt(u);
    final double t = 2 * pi * v;
    final double x = w * cos(t);
    final double y = w * sin(t);

    final double newX = x / cos(userLatitude);
    final double foundLongitude = y + userLongitude;

    final double generatedLatitude = userLatitude + newX;
    final double generatedLongitude = foundLongitude;

    activityLocations.add(Location(latitude: generatedLatitude, longitude: generatedLongitude));
  }

  return activityLocations;
}
