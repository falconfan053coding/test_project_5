import 'package:hive_flutter/hive_flutter.dart';
import 'package:latest_news/src/presentation/bookmark/data/model/bookmark_news_model.dart';
import 'package:latest_news/src/presentation/home/data/model/news_model.dart';

class HiveService {
  static const String _boxName = 'bookmarks';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BookmarkNewsModelAdapter());
    await Hive.openBox<BookmarkNewsModel>(_boxName);
  }

  Future<void> addBookmark(NewsModel news) async {
    var box = Hive.box<BookmarkNewsModel>(_boxName);
    final bookmark = BookmarkNewsModel(
      host: news.host,
      imageURL: news.ImageURL,
      dateTime: news.dateTime,
      publisher: news.articleAuthor,
      timeStamp: news.timeStamp,
      articleUrl: news.articleUrl,
      articleDate: news.articleDate,
      articleTime: news.articleTime,
      sectionItem: news.articleSection,
      articleTitle: news.articleTitle,
      runTimestamp: news.runTimestamp,
      articleAuthor: news.articleAuthor,
      publisherHost: news.publisherHost,
      timePublished: news.timePublished,
      articleSection: news.articleSection,
    );

    await box.add(bookmark);
  }

  Future<void> deleteBookmark(String articleUrl) async {
    var box = Hive.box<BookmarkNewsModel>(_boxName);
    final bookmarks = box.values.where((item) => item.articleUrl == articleUrl).toList();
    for (var bookmark in bookmarks) {
      await bookmark.delete(); // Deletes the bookmark
    }
  }

  Future<List<BookmarkNewsModel>> getBookmarks() async {
    var box = Hive.box<BookmarkNewsModel>(_boxName);
    return box.values.toList();
  }
}
