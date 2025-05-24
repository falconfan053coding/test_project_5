import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_news/app/di/dependency_injection.dart';
import 'package:latest_news/app/router.dart';
import 'package:latest_news/app/theme.dart';
import 'package:latest_news/src/presentation/home/bloc/home_bloc.dart';
import 'package:latest_news/src/presentation/main/bloc/bottom_navigation_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBloc>(create: (context) => getIt<BottomNavigationBloc>()),
        BlocProvider<HomeBloc>(create: (context) => getIt<HomeBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Headline News',
        themeMode: ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: router,
      ),
    );
  }
}
