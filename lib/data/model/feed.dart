import 'package:json_annotation/json_annotation.dart';
import 'package:perfect_feed/data/model/user.dart';


class Feed {
  final int id;
  final ActivityTypeEnum activityType;
  final String title;
  final Location activityLocation;


  Feed({required this.id, required this.activityType, required this.title, required this.activityLocation});

}

enum ActivityTypeEnum {
  activityType1,
  activityType2,
  activityType3,
  activityType4,
  activityType5,
  activityType6,
}
