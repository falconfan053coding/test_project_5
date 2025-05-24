import 'package:equatable/equatable.dart' show Equatable;
import 'package:latest_news/core/api/error/failure.dart';
import 'package:latest_news/src/presentation/home/data/model/news_model.dart';
import '../../../../../core/utils/status.dart';

class HomeState extends Equatable {
  final Status status;
  final Status worldNewsStatus;
  final Status sportsNewsStatus;
  final Status scienceNewsStatus;
  final Status businessNewsStatus;
  final Status generalNewsStatus;
  final List<NewsModel>? worldNews;
  final List<NewsModel>? sportsNews;
  final List<NewsModel>? scienceNews;
  final List<NewsModel>? businessNews;
  final List<NewsModel>? generalNews;
  final List<NewsModel>? allNews;
  final Failure? failure;

  const HomeState({
    this.status = Status.fail,
    this.worldNewsStatus = Status.fail,
    this.sportsNewsStatus = Status.fail,
    this.scienceNewsStatus = Status.fail,
    this.businessNewsStatus = Status.fail,
    this.generalNewsStatus = Status.fail,
    this.worldNews,
    this.sportsNews,
    this.scienceNews,
    this.businessNews,
    this.generalNews,
    this.allNews,
    this.failure,
  });

  HomeState copyWith({
    Status? status,
    Status? worldNewsStatus,
    Status? sportsNewsStatus,
    Status? scienceNewsStatus,
    Status? businessNewsStatus,
    Status? generalNewsStatus,
    List<NewsModel>? worldNews,
    List<NewsModel>? sportsNews,
    List<NewsModel>? scienceNews,
    List<NewsModel>? businessNews,
    List<NewsModel>? generalNews,
    List<NewsModel>? allNews,
    Failure? failure,
  }) {
    return HomeState(
      status: status ?? this.status,
      worldNewsStatus: worldNewsStatus ?? this.worldNewsStatus,
      sportsNewsStatus: sportsNewsStatus ?? this.sportsNewsStatus,
      scienceNewsStatus: scienceNewsStatus ?? this.scienceNewsStatus,
      businessNewsStatus: businessNewsStatus ?? this.businessNewsStatus,
      generalNewsStatus: generalNewsStatus ?? this.generalNewsStatus,
      worldNews: worldNews ?? this.worldNews,
      sportsNews: sportsNews ?? this.sportsNews,
      scienceNews: scienceNews ?? this.scienceNews,
      businessNews: businessNews ?? this.businessNews,
      generalNews: generalNews ?? this.generalNews,
      allNews: allNews ?? this.allNews,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        worldNewsStatus,
        sportsNewsStatus,
        scienceNewsStatus,
        businessNewsStatus,
        generalNewsStatus,
        worldNews,
        sportsNews,
        scienceNews,
        businessNews,
        generalNews,
        allNews,
        failure,
      ];
}
