import 'package:either_dart/src/either.dart';
import 'package:latest_news/core/api/error/failure.dart';
import 'package:latest_news/core/api/interceptor/interceptor.dart';
import 'package:latest_news/src/presentation/home/data/model/news_model.dart';
import 'package:latest_news/src/presentation/home/domain/repository/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {

  @override
  Future<Either<Failure, List<NewsModel>>> getNews({required String link}) async {
    final res = await ApiClient().getMethod(
      pathUrl: "/$link",
      isHeader: false,
    );
    if (res.isSuccess) {
      List<NewsModel> newsList = (res.response as List)
          .map((newsItem) => NewsModel.fromJson(newsItem))
          .toList();
      return Right(newsList);
    }
    return Left(Failure(errorMsg: res.response));
  }


}
