
import 'package:get_it/get_it.dart';
import 'package:latest_news/src/presentation/home/bloc/home_bloc.dart';
import 'package:latest_news/src/presentation/home/data/repository_impl/news_repository_impl.dart';
import 'package:latest_news/src/presentation/home/domain/repository/news_repository.dart';
import 'package:latest_news/src/presentation/main/bloc/bottom_navigation_bloc.dart';


final getIt = GetIt.instance;

void setUp() {

  getIt.registerFactory(() => BottomNavigationBloc());
  getIt.registerFactory(() => HomeBloc(getIt<NewsRepository>()));
  getIt.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl());
  // getIt.registerLazySingleton<ChatRepo>(() => ChatRepoImpl());
  // getIt.registerFactory(() => ManageBookingBloc(
  //       getIt<MasterHomeRepo>(),
  //       getIt<ChatRepo>(),
  //     ));
}
