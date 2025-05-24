import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:latest_news/src/presentation/home/data/model/news_model.dart';
import 'package:latest_news/src/presentation/home/domain/repository/news_repository.dart';
import '../../../../../core/utils/status.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewsRepository _repository;

  HomeBloc(this._repository) : super(const HomeState()) {
    on<GetWorldNews>(_getWorldNews);
    on<GetSportsNews>(_getSportsNews);
    on<GetScienceNews>(_getScienceNews);
    on<GetBusinessNews>(_getBusinessNews);
    on<GetGeneralNews>(_getGeneralNews);
    on<GetAllNews>(_getAllNews);
  }

  List<NewsModel> _filterDuplicates(List<NewsModel> newNews, List<NewsModel>? existingNews) {
    final existingIds = existingNews?.map((news) => news.articleTitle).toSet() ?? {};
    return newNews.where((news) => !existingIds.contains(news.articleTitle)).toList();
  }

  _getAllNews(GetAllNews event, Emitter<HomeState> emit) async {
    log("log get all news $event ${DateTime.now()}");
    emit(state.copyWith(status: Status.loading, allNews: null));
    final res = await _repository.getNews(link: event.link);
    res.fold(
      (l) => emit(state.copyWith(status: Status.error, failure: l)),
      (r) {
        final filteredAllNews = _filterDuplicates(r, state.allNews);
        emit(state.copyWith(
          status: Status.success,
          // allNews: filteredAllNews,
          allNews: r,
        ));
      },
    );
  }

  _getWorldNews(GetWorldNews event, Emitter<HomeState> emit) async {
    log("log get world news $event ${DateTime.now()}");
    emit(state.copyWith(worldNewsStatus: Status.loading, worldNews: null));
    final res = await _repository.getNews(link: event.link);
    res.fold(
      (l) => emit(state.copyWith(worldNewsStatus: Status.error, failure: l)),
      (r) {
        final filteredWorldNews = _filterDuplicates(r, state.worldNews);
        // List<NewsModel> updatedAllNews = [...?state.allNews, ...filteredWorldNews];
        emit(state.copyWith(
          worldNewsStatus: Status.success,
          // worldNews: filteredWorldNews,
          worldNews: r,
          // allNews: updatedAllNews,
        ));
      },
    );
  }

  _getSportsNews(GetSportsNews event, Emitter<HomeState> emit) async {
    log("log get sports news $event ${DateTime.now()}");
    emit(state.copyWith(sportsNewsStatus: Status.loading, sportsNews: null));
    final res = await _repository.getNews(link: event.link);
    res.fold(
      (l) => emit(state.copyWith(sportsNewsStatus: Status.error, failure: l)),
      (r) {
        final filteredSportsNews = _filterDuplicates(r, state.sportsNews);
        emit(state.copyWith(
          sportsNewsStatus: Status.success,
          // sportsNews: filteredSportsNews,
          sportsNews: r,
          // allNews: updatedAllNews,
        ));
      },
    );
  }

  _getScienceNews(GetScienceNews event, Emitter<HomeState> emit) async {
    log("log get science news $event ${DateTime.now()}");
    emit(state.copyWith(scienceNewsStatus: Status.loading, scienceNews: null));
    final res = await _repository.getNews(link: event.link);
    res.fold(
      (l) => emit(state.copyWith(scienceNewsStatus: Status.error, failure: l)),
      (r) {
        final filteredScienceNews = _filterDuplicates(r, state.scienceNews);
        // List<NewsModel> updatedAllNews = [...?state.allNews, ...filteredScienceNews];
        emit(state.copyWith(
          scienceNewsStatus: Status.success,
          // scienceNews: [...?state.scienceNews, ...filteredScienceNews],
          scienceNews: r,
          // allNews: updatedAllNews,
        ));
      },
    );
  }

  _getBusinessNews(GetBusinessNews event, Emitter<HomeState> emit) async {
    log("log get business news $event ${DateTime.now()}");
    emit(state.copyWith(businessNewsStatus: Status.loading, businessNews: []));
    final res = await _repository.getNews(link: event.link);
    res.fold(
      (l) => emit(state.copyWith(businessNewsStatus: Status.error, failure: l)),
      (r) {
        final filteredBusinessNews = _filterDuplicates(r, state.businessNews);
        emit(state.copyWith(
          businessNewsStatus: Status.success,
          businessNews: r,
          // allNews: updatedAllNews,
        ));
      },
    );
  }

  _getGeneralNews(GetGeneralNews event, Emitter<HomeState> emit) async {
    log("log get general news $event ${DateTime.now()}");
    emit(state.copyWith(generalNewsStatus: Status.loading, generalNews: null));
    final res = await _repository.getNews(link: event.link);
    res.fold(
      (l) => emit(state.copyWith(generalNewsStatus: Status.error, failure: l)),
      (r) {
        final filteredGeneralNews = _filterDuplicates(r, state.generalNews);
        // List<NewsModel> updatedAllNews = [...?state.allNews, ...filteredGeneralNews];
        emit(state.copyWith(
          generalNewsStatus: Status.success,
          // generalNews: filteredGeneralNews,
          generalNews: r,
          // allNews: updatedAllNews,
        ));
      },
    );
  }
}
