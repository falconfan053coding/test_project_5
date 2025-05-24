// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkNewsModelAdapter extends TypeAdapter<BookmarkNewsModel> {
  @override
  final int typeId = 111;

  @override
  BookmarkNewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkNewsModel(
      host: fields[0] as String?,
      imageURL: fields[1] as dynamic,
      dateTime: fields[2] as String?,
      publisher: fields[3] as String?,
      timeStamp: fields[4] as DateTime?,
      articleUrl: fields[5] as String?,
      articleDate: fields[6] as String?,
      articleTime: fields[7] as String?,
      sectionItem: fields[8] as String?,
      articleTitle: fields[9] as String?,
      runTimestamp: fields[10] as String?,
      articleAuthor: fields[11] as dynamic,
      publisherHost: fields[12] as String?,
      timePublished: fields[13] as String?,
      articleSection: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkNewsModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.host)
      ..writeByte(1)
      ..write(obj.imageURL)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.publisher)
      ..writeByte(4)
      ..write(obj.timeStamp)
      ..writeByte(5)
      ..write(obj.articleUrl)
      ..writeByte(6)
      ..write(obj.articleDate)
      ..writeByte(7)
      ..write(obj.articleTime)
      ..writeByte(8)
      ..write(obj.sectionItem)
      ..writeByte(9)
      ..write(obj.articleTitle)
      ..writeByte(10)
      ..write(obj.runTimestamp)
      ..writeByte(11)
      ..write(obj.articleAuthor)
      ..writeByte(12)
      ..write(obj.publisherHost)
      ..writeByte(13)
      ..write(obj.timePublished)
      ..writeByte(14)
      ..write(obj.articleSection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkNewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
