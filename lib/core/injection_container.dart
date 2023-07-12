import 'package:perfect_feed/data/data_source/feeds_remote_data_source.dart';
import 'package:perfect_feed/data/data_source/user_local_data_source.dart';
import 'package:perfect_feed/repository/feeds_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_feed/repository/user_repository.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSource());
  getIt.registerLazySingleton<FeedsRemoteDataSource>(() => FeedsRemoteDataSource());

  getIt.registerLazySingleton<FeedsRepository>(() => FeedsRepository(getIt()));
  getIt.registerLazySingleton<UserRepository>(() => UserRepository(getIt()));
}
