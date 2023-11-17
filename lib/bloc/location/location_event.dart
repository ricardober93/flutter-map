part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnLocationUpdate extends LocationEvent {
  final LatLng lastLocation;

  const OnLocationUpdate(this.lastLocation);

  @override
  List<Object> get props => [lastLocation];
}

class OnStartFollowUser extends LocationEvent {}

class OnStopFlowing extends LocationEvent {}
