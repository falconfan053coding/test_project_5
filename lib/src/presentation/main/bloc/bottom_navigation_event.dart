part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}

class SetNotificationCountEvent extends BottomNavigationEvent {
  final int notificationCount;

  SetNotificationCountEvent({required this.notificationCount});
}

class SetFavoriteCountEvent extends BottomNavigationEvent {
  final int favoriteCount;

  SetFavoriteCountEvent({required this.favoriteCount});
}

class SetBottomNavigationIndexEvent extends BottomNavigationEvent {
  final int index;

  SetBottomNavigationIndexEvent({required this.index});
}
