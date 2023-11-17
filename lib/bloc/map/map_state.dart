part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitized;
  final bool isFollowingUser;
  final bool showMyRoute;

  final Map<String, Polyline> polylines;

  const MapState({
    this.isMapInitized = false,
    this.isFollowingUser = false,
    this.showMyRoute = false,
    Map<String, Polyline>? polylines,
  }) : polylines = polylines ?? const {};

  MapState copyWith({
    bool? isMapInitized,
    bool? isFollowingUser,
    Map<String, Polyline>? polylines,
    bool? showMyRoute,
  }) {
    return MapState(
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
      isMapInitized: isMapInitized ?? this.isMapInitized,
      showMyRoute: showMyRoute ?? this.showMyRoute,
      polylines: polylines ?? this.polylines,
    );
  }

  @override
  List<Object> get props => [polylines, isMapInitized, isFollowingUser];
}
