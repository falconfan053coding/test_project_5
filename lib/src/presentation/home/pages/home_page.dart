import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:latest_news/app/theme.dart';
import 'package:latest_news/src/presentation/home/pages/all_news_page.dart';
import 'package:latest_news/src/presentation/home/pages/business_news_page.dart';
import 'package:latest_news/src/presentation/home/pages/general_news_page.dart';
import 'package:latest_news/src/presentation/home/pages/science_news_page.dart';
import 'package:latest_news/src/presentation/home/pages/sports_news_page.dart';
import 'package:latest_news/src/presentation/home/pages/world_news_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        title: const Text(
          "Headline News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.background,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyColors.primary,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonsTabBar(
              radius: 15,
              contentCenter: true,
              width: 100,
              backgroundColor: Colors.redAccent,
              unselectedBackgroundColor: Colors.white.withOpacity(0.7),
              unselectedLabelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
              labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: "World"),
                Tab(text: "Business"),
                Tab(text: "News"),
                Tab(text: "Sports"),
                Tab(text: "Other"),
                Tab(text: "All news")

              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  WorldNewsPage(),
                  BusinessNewsPage(),
                  GeneralNewsPage(),
                  SportsNewsPage(),
                  ScienceNewsPage(),
                  AllNewsPage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
