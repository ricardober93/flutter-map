part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarker extends SearchEvent {}

class OnDeactivateManualMarker extends SearchEvent {}
