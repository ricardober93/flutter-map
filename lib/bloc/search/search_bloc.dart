import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnActivateManualMarker>((event, emit) {
      emit(state.copyWith(displayManualMarker: true));
    });

    on<OnDeactivateManualMarker>((event, emit) {
      emit(state.copyWith(displayManualMarker: false));
    });
  }
}
