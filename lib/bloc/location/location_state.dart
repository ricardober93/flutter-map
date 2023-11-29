part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool following;
  final LatLng? lastLocation;
  final List<LatLng> routeHistory;

  const LocationState(
      {this.following = false, this.lastLocation, routeHistory})
      : routeHistory = routeHistory ?? const [];

  LocationState copyWith({
    bool? following,
    LatLng? lastLocation,
    List<LatLng>? routeHistory,
  }) =>
      LocationState(
        following: following ?? this.following,
        lastLocation: lastLocation ?? this.lastLocation,
        routeHistory: routeHistory ?? this.routeHistory,
      );

  @override
  List<Object?> get props => [following, lastLocation, routeHistory];
}
