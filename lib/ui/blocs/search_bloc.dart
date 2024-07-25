import 'package:ballastlane_app/domain/entities/tv_show.dart';
import 'package:ballastlane_app/domain/repositories/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class SearchEvent {}

class EmptySearch extends SearchEvent {}

/// TODO: ver si es posible implementar debounce
class SearchQuery extends SearchEvent {
  final String query;

  SearchQuery({required this.query});
}

sealed class SearchState {}

class EmptyResults extends SearchState {}

class ErrorOfSearch extends SearchState {
  final String message;

  ErrorOfSearch(this.message);
}

class ListedResults extends SearchState {
  final List<TvShowResult> results;

  ListedResults(this.results);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiRepository apiRepository;
  SearchBloc(this.apiRepository) : super(EmptyResults()) {
    on<EmptySearch>(
      (event, emit) => emit(ErrorOfSearch('message')),
    );
    on<SearchQuery>(
      (event, emit) => _queryShows(emit, event.query),
    );
  }

  void _queryShows(Emitter<SearchState> emit, String query) async {
    if (query.isEmpty) {
      emit(ErrorOfSearch('There\'s nothing to search'));
      return;
    }
    List<TvShowResult> results = await apiRepository.fetchTvShows(query);
    emit(ListedResults(results));
  }
}
