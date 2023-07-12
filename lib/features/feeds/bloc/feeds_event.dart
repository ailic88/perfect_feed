part of 'feeds_bloc.dart';

abstract class FeedsEvent {}

class GetMoreFeedsEvent extends FeedsEvent {}

class AddFavoriteActivityEvent extends FeedsEvent {
  final ActivityTypeEnum activity;

  AddFavoriteActivityEvent(this.activity);
}

class SetUserFeedRadiusEvent extends FeedsEvent {
  final double radius;

  SetUserFeedRadiusEvent(this.radius);
}


class ResetEvent extends FeedsEvent {

}