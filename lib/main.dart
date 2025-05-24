import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_news/app/app.dart';
import 'package:latest_news/app/di/dependency_injection.dart';
import 'package:latest_news/core/utils/app_bloc_observer.dart';
import 'package:latest_news/src/presentation/bookmark/data/bookmark_hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HiveService hiveService = HiveService();
  await hiveService.init();

  Bloc.observer = const AppBlocObserver();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setUp();


  runApp(
    const App(),
  );
}
