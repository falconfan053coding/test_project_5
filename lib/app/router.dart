import 'package:go_router/go_router.dart';
import 'package:latest_news/src/presentation/main/page/main_page.dart';
import 'package:latest_news/src/presentation/news/pages/product_screen.dart';

abstract class Routes {
  // static const splashPage = '/splashPage';
  static const mainPage = '/mainPage';
  static const homePage = '/homePage';
  static const searchPage = '/searchPage';
  static const newsPage = '/newsPage';
  static const bookmarksPage = '/bookmarksPage';
  static const productPage = '/productPage';
}

String _initialLocation() {
  return Routes.mainPage;
}

Object? _initialExtra() {
  return null;
}

final router = GoRouter(
  initialLocation: _initialLocation(),
  initialExtra: _initialExtra(),
  routes: [
    GoRoute(
      path: Routes.mainPage,
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: Routes.productPage,
      builder: (context, state) {
        final url = state.extra as String ?? "";
        return ProductScreen(url: url,);
      },
    ),
  ],
);
