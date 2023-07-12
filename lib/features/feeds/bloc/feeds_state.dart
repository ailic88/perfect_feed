part of 'feeds_bloc.dart';

abstract class FeedsState {
  final List<Feed> feeds;
  final double radius;

  const FeedsState(this.feeds, this.radius);
}

class FeedsInitial extends FeedsState {
  FeedsInitial() : super([], maxRadiusInKm);
}

class LoadedFeedsState extends FeedsState {
  const LoadedFeedsState(List<Feed> feeds, double raduis) : super(feeds, raduis);
}
