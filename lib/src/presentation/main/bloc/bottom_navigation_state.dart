part of 'bottom_navigation_bloc.dart';

class BottomNavigationState {
  final int? notificationCount;
  final int? favoriteCount;
  final int index;

  BottomNavigationState({this.favoriteCount = 0, this.notificationCount = 0, this.index = 0});

  BottomNavigationState copyWith({
    int? notificationCount,
    int? index,
    int? favoriteCount,
  }) =>
      BottomNavigationState(
        index: index ?? this.index,
        notificationCount: notificationCount ?? this.notificationCount,
        favoriteCount: favoriteCount ?? this.favoriteCount,
      );
}
