import 'package:bloc/bloc.dart';
import 'package:perfect_feed/core/const.dart';
import 'package:perfect_feed/data/model/feed.dart';
import 'package:perfect_feed/data/model/user.dart';
import 'package:perfect_feed/repository/feeds_repository.dart';
import 'package:perfect_feed/repository/user_repository.dart';

part 'feeds_event.dart';

part 'feeds_state.dart';

const activitiesRadius = 100.00; //100km

class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  final FeedsRepository _feedsRepository;
  final UserRepository _userRepository;

  FeedsBloc(this._feedsRepository, this._userRepository) : super(FeedsInitial()) {
    on<GetMoreFeedsEvent>((event, emit) async {
      final feeds = List.of(state.feeds);
      final user = _userRepository.getUser();

      final List<Feed> newFeeds = await _feedsRepository.getFeeds(user);
      feeds.addAll(newFeeds);

      emit(LoadedFeedsState(feeds, user.radiusInKm));
    });
    add(GetMoreFeedsEvent());

    on<AddFavoriteActivityEvent>((event, emit) async {
      final user = _userRepository.getUser();
      await _userRepository.storeUser(user.copyWith(preferedActivity: {...user.preferedActivity, event.activity}));
    });

    on<SetUserFeedRadiusEvent>((event, emit) async {
      await _userRepository.storeUser(_userRepository.getUser().copyWith(radiusInKm: event.radius));
      emit(LoadedFeedsState(state.feeds, _userRepository.getUser().radiusInKm));
    });

    on<ResetEvent>((event, emit) async {
      await _userRepository.storeUser(User());
      _feedsRepository.reset();
      emit(const LoadedFeedsState([], maxRadiusInKm));
      add(GetMoreFeedsEvent());
    });
  }
}
