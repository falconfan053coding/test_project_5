// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsModelImpl _$$NewsModelImplFromJson(Map<String, dynamic> json) =>
    _$NewsModelImpl(
      host: json['host'] as String?,
      ImageURL: json['ImageURL'],
      dateTime: json['dateTime'] as String?,
      publisher: json['publisher'] as String?,
      timeStamp: json['timeStamp'] == null
          ? null
          : DateTime.parse(json['timeStamp'] as String),
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
      displaySection: json['displaySection'] as String?,
    );

Map<String, dynamic> _$$NewsModelImplToJson(_$NewsModelImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
      'ImageURL': instance.ImageURL,
      'dateTime': instance.dateTime,
      'publisher': instance.publisher,
      'timeStamp': instance.timeStamp?.toIso8601String(),
      'articleUrl': instance.articleUrl,
      'articleDate': instance.articleDate,
      'articleTime': instance.articleTime,
      'sectionItem': instance.sectionItem,
      'articleTitle': instance.articleTitle,
      'runTimestamp': instance.runTimestamp,
      'articleAuthor': instance.articleAuthor,
      'publisherHost': instance.publisherHost,
      'timePublished': instance.timePublished,
      'articleSection': instance.articleSection,
      'displaySection': instance.displaySection,
    };
