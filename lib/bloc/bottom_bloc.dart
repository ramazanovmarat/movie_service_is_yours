import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BottomEvent {}

class AppStarted extends BottomEvent {}

class ViewTapped extends BottomEvent {
  final int index;

  ViewTapped({required this.index});
}



abstract class BottomState {}

class CurrentIndexChanged extends BottomState {
  final int currentIndex;

  CurrentIndexChanged({required this.currentIndex});

}

class ViewLoading extends BottomState {}

class HomeLoaded extends BottomState {}
class CatalogLoaded extends BottomState {}
class FavoritesLoaded extends BottomState {}
class TVLoaded extends BottomState {}
class ProfileLoaded extends BottomState {}


class BottomBloc extends Bloc<BottomEvent, BottomState> {
  int currentIndex = 0;

  BottomBloc() : super(ViewLoading()) {
    on<BottomEvent>((event, emit) async {
      if(emit is AppStarted) {
        add(ViewTapped(index: currentIndex));
      }
      if(event is ViewTapped) {
        currentIndex = event.index;
        emit(CurrentIndexChanged(currentIndex: currentIndex));
        emit(ViewLoading());
      }
      if(currentIndex == 0) {
        emit(HomeLoaded());
      }
      if(currentIndex == 1) {
        emit(CatalogLoaded());
      }
      if(currentIndex == 2) {
        emit(FavoritesLoaded());
      }
      if(currentIndex == 3) {
        emit(TVLoaded());
      }
      if(currentIndex == 4) {
        emit(ProfileLoaded());
      }
    });
  }
}