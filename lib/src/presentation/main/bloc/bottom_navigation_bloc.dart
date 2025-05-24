import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_event.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationState()) {

    on<SetNotificationCountEvent>((event, emit) {
      emit(state.copyWith(notificationCount: event.notificationCount));
    });

    on<SetFavoriteCountEvent>((event, emit) {
      emit(state.copyWith(favoriteCount: event.favoriteCount));
    });

    on<SetBottomNavigationIndexEvent>((event, emit) {
      emit(state.copyWith(index: event.index));
    });
  }
}
