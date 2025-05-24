import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    String? host,
    dynamic ImageURL,
    String? dateTime,
    String? publisher,
    DateTime? timeStamp,
    String? articleUrl,
    String? articleDate,
    String? articleTime,
    String? sectionItem,
    String? articleTitle,
    String? runTimestamp,
    dynamic articleAuthor,
    String? publisherHost,
    String? timePublished,
    String? articleSection,
    String? displaySection
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);
}

