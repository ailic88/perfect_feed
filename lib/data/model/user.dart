import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:perfect_feed/core/const.dart';
import 'package:perfect_feed/data/model/feed.dart';

class User {
  final String? firstName;
  final String? lastName;
  final Set<ActivityTypeEnum> preferedActivity;
  final Location userLocation;
  final double radiusInKm;

  User({
    this.firstName,
    this.lastName,
    this.preferedActivity = const {},
    this.userLocation = const Location(latitude: userLatitude, longitude: userLongitude),
    this.radiusInKm = maxRadiusInKm,
  });


  User copyWith({
    Set<ActivityTypeEnum>? preferedActivity,
    Location? userLocation,
    double? radiusInKm,
  }) {
    return User(
      preferedActivity: preferedActivity ?? this.preferedActivity,
      userLocation: userLocation ?? this.userLocation,
      radiusInKm: radiusInKm ?? this.radiusInKm,
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  const Location({required this.latitude, required this.longitude});

}
