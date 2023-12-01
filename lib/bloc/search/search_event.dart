part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarker extends SearchEvent {}

class OnDeactivateManualMarker extends SearchEvent {}

class OnNewPlacesEvents extends SearchEvent {
  final List<Feature> places;

  const OnNewPlacesEvents(this.places);

  @override
  List<Object> get props => [places];
}

class OnNewHistoryEvents extends SearchEvent {
  final Feature history;

  const OnNewHistoryEvents(this.history);

  @override
  List<Object> get props => [history];
}
