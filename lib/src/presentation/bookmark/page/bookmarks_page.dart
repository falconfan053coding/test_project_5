import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latest_news/app/theme.dart';
import 'package:latest_news/src/presentation/bookmark/data/model/bookmark_news_model.dart';
import 'package:latest_news/src/presentation/home/widget/build_news_card.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: MyColors.primary,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Bookmarked",
            style: TextStyle(
              color: MyColors.background,
            ),
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(0.3),
        body: Column(
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
              ],
            ),
            const SizedBox(height: 10), // Optional spacing
            Expanded(
              child: TabBarView(
                children: [
                  _buildCategoryBookmarksList('World'),
                  _buildCategoryBookmarksList('Business'),
                  _buildCategoryBookmarksList('News'),
                  _buildCategoryBookmarksList('Sports'),
                  _buildCategoryBookmarksList('Science'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildCategoryBookmarksList(String category) {
    return ValueListenableBuilder<Box<BookmarkNewsModel>>(
      valueListenable: Hive.box<BookmarkNewsModel>('bookmarks').listenable(),
      builder: (context, box, _) {
        final categoryBookmarks = box.values.where((bookmark) {
          return bookmark.articleSection == category; // Filter bookmarks by category
        }).toList();

        if (categoryBookmarks.isEmpty) {
          return Center(child: Text("No $category bookmarks found"));
        }
        return ListView.builder(
          itemCount: categoryBookmarks.length,
          itemBuilder: (context, index) {
            final bookmark = categoryBookmarks[index];
            final newsModel = bookmark.toNewsModel();
          //  Color cardColor = index % 2 == 0 ? Colors.red.withOpacity(0.6) : Colors.orangeAccent.shade200.withOpacity(0.6);
            Color cardColor = index % 2 == 0 ? Colors.yellow.shade100 : Colors.greenAccent.shade100;
          //  Color cardColor = index % 2 == 0 ? Colors.lightBlueAccent.shade100 : Colors.orangeAccent.shade100;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: .9,
                        color: Colors.grey
                      ),
                    ),
                    child: NewsCard(
                      news: newsModel,
                    ),
                  ),
                ),
                //    const Divider(),
              ],
            );
          },
        );
      },
    );
  }
}
