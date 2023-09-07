import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_service_is_yours/models.dart';

// Event
abstract class MovieEvent {}

class FetchMovieEvent extends MovieEvent {}

// State
abstract class MovieState {}

class InitialState extends MovieState {}

class LoadingState extends MovieState {}

class LoadedState extends MovieState {
  final MovieModels data;
  LoadedState(this.data);
}

class ErrorState extends MovieState {
  final String error;
  ErrorState(this.error);
}

// Bloc
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(InitialState()) {
    on<FetchMovieEvent>(_fetchMovie);
  }

  void _fetchMovie(FetchMovieEvent event, Emitter<MovieState> emit) {
    emit(LoadingState());

    try {
      final MovieModels movieModels = MovieModels(
          textData: 'Жители Хоукинса — дети, подростки и взрослые — сталкиваются с влиянием чуждого и опасного параллельного измерения.',
          imageUrls: 'assets/images/film.jpg',
          filmImage: 'assets/images/yenzdey.png',
          movieName: 'Уэнздей',
          seasonAndSeries: '1 сезон 4 серия',
      );
      emit(LoadedState(movieModels));
    } catch (e) {
      emit(ErrorState('Ошибка при загрузке данных: $e'));
    }
  }

}
