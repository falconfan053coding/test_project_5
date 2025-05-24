import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetWorldNews extends HomeEvent {
  final String link;

  const GetWorldNews({required this.link});

  @override
  List<Object> get props => [link];
}

class GetSportsNews extends HomeEvent {
  final String link;

  const GetSportsNews({required this.link});

  @override
  List<Object> get props => [link];
}

class GetScienceNews extends HomeEvent {
  final String link;

  const GetScienceNews({required this.link});

  @override
  List<Object> get props => [link];
}

class GetBusinessNews extends HomeEvent {
  final String link;

  const GetBusinessNews({required this.link});

  @override
  List<Object> get props => [link];
}

class GetGeneralNews extends HomeEvent {
  final String link;

  const GetGeneralNews({required this.link});

  @override
  List<Object> get props => [link];
}

class GetAllNews extends HomeEvent {
  final String link;

  const GetAllNews({required this.link});

  @override
  List<Object> get props => [link];
}
