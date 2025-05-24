import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latest_news/app/theme.dart';
import 'package:latest_news/core/constants/constants.dart';
import 'package:latest_news/src/presentation/bookmark/page/bookmarks_page.dart';
import 'package:latest_news/src/presentation/home/bloc/home_bloc.dart';
import 'package:latest_news/src/presentation/home/bloc/home_event.dart';
import 'package:latest_news/src/presentation/home/pages/home_page.dart';
import 'package:latest_news/src/presentation/main/bloc/bottom_navigation_bloc.dart';
import 'package:latest_news/src/presentation/search/page/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = CupertinoTabController();

  @override
  void initState() {
    context.read<HomeBloc>().add(const GetWorldNews(link: Constants.worldNewsLink));
    context.read<HomeBloc>().add(const GetSportsNews(link: Constants.sportsNewsLink));
    context.read<HomeBloc>().add(const GetScienceNews(link: Constants.scienceNewsLink));
    context.read<HomeBloc>().add(const GetBusinessNews(link: Constants.businessNewsLink));
    context.read<HomeBloc>().add(const GetGeneralNews(link: Constants.generalNewsLink));
    context.read<HomeBloc>().add(const GetAllNews(link: Constants.allNewsLink));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        int selectedIndex = state.index;
        controller.index = state.index;
        return CupertinoTabScaffold(
          controller: controller,
          tabBar: CupertinoTabBar(
            height: kBottomNavigationBarHeight,
            backgroundColor: MyColors.primary,
            activeColor: MyColors.primary,
            inactiveColor: MyColors.inactive,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: selectedIndex == 0
                    ? SvgPicture.asset(
                        'assets/svg/home_selected.svg',
                        width: 24,
                        color: Colors.white,
                      )
                    : SvgPicture.asset(
                        'assets/svg/home_unselected.svg',
                        width: 24,
                        color: Colors.white,
                      ),
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 1
                    ? SvgPicture.asset(
                        'assets/svg/search_selected.svg',
                        width: 24,
                        color: Colors.white,
                      )
                    : SvgPicture.asset(
                        'assets/svg/search_unselected.svg',
                        width: 24,
                        color: Colors.white,
                      ),
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 2
                    ? SvgPicture.asset(
                        'assets/svg/bookmark_selected.svg',
                        width: 24,
                        color: Colors.white,
                      )
                    : SvgPicture.asset(
                        'assets/svg/bookmark_unselected.svg',
                        width: 24,
                        color: Colors.white,
                      ),
              ),
            ],
            onTap: (index) {
              context.read<BottomNavigationBloc>().add(SetBottomNavigationIndexEvent(index: index));
            },
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return _buildPage(index);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const SearchPage();
      case 2:
        return const BookmarksPage();
      default:
        return const HomePage();
    }
  }
}
