import 'package:hive/hive.dart';
import 'package:latest_news/src/presentation/home/data/model/news_model.dart';

part 'bookmark_news_model.g.dart';

@HiveType(typeId: 111)
class BookmarkNewsModel extends HiveObject {
  @HiveField(0)
  final String? host;

  @HiveField(1)
  final dynamic imageURL;

  @HiveField(2)
  final String? dateTime;

  @HiveField(3)
  final String? publisher;

  @HiveField(4)
  final DateTime? timeStamp;

  @HiveField(5)
  final String? articleUrl;

  @HiveField(6)
  final String? articleDate;

  @HiveField(7)
  final String? articleTime;

  @HiveField(8)
  final String? sectionItem;

  @HiveField(9)
  final String? articleTitle;

  @HiveField(10)
  final String? runTimestamp;

  @HiveField(11)
  final dynamic articleAuthor;

  @HiveField(12)
  final String? publisherHost;

  @HiveField(13)
  final String? timePublished;

  @HiveField(14)
  final String? articleSection;

  BookmarkNewsModel({
    this.host,
    this.imageURL,
    this.dateTime,
    this.publisher,
    this.timeStamp,
    this.articleUrl,
    this.articleDate,
    this.articleTime,
    this.sectionItem,
    this.articleTitle,
    this.runTimestamp,
    this.articleAuthor,
    this.publisherHost,
    this.timePublished,
    this.articleSection,
  });

  factory BookmarkNewsModel.fromJson(Map<String, dynamic> json) {
    return BookmarkNewsModel(
      host: json['host'] as String?,
      imageURL: json['imageURL'],
      dateTime: json['dateTime'] as String?,
      publisher: json['publisher'] as String?,
      timeStamp: json['timeStamp'] != null ? DateTime.parse(json['timeStamp']) : null,
      articleUrl: json['articleUrl'] as String?,
      articleDate: json['articleDate'] as String?,
      articleTime: json['articleTime'] as String?,
      sectionItem: json['sectionItem'] as String?,
      articleTitle: json['articleTitle'] as String?,
      runTimestamp: json['runTimestamp'] as String?,
      articleAuthor: json['articleAuthor'],
      publisherHost: json['publisherHost'] as String?,
      timePublished: json['timePublished'] as String?,
      articleSection: json['articleSection'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'imageURL': imageURL,
      'dateTime': dateTime,
      'publisher': publisher,
      'timeStamp': timeStamp?.toIso8601String(),
      'articleUrl': articleUrl,
      'articleDate': articleDate,
      'articleTime': articleTime,
      'sectionItem': sectionItem,
      'articleTitle': articleTitle,
      'runTimestamp': runTimestamp,
      'articleAuthor': articleAuthor,
      'publisherHost': publisherHost,
      'timePublished': timePublished,
      'articleSection': articleSection,
    };
  }

  NewsModel toNewsModel() {
    return NewsModel(
      host: host,
      ImageURL: imageURL,
      dateTime: dateTime,
      publisher: publisher,
      timeStamp: timeStamp,
      articleUrl: articleUrl,
      articleDate: articleDate,
      articleTime: articleTime,
      sectionItem: sectionItem,
      articleTitle: articleTitle,
      runTimestamp: runTimestamp,
      articleAuthor: articleAuthor,
      publisherHost: publisherHost,
      timePublished: timePublished,
      articleSection: articleSection,
    );
  }
}
