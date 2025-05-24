import 'package:either_dart/either.dart';
import 'package:latest_news/core/api/error/failure.dart';
import 'package:latest_news/src/presentation/home/data/model/news_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsModel>>> getNews({required String link});
}
