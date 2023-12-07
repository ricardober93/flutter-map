part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitized;
  final bool isFollowingUser;
  final bool showMyRoute;

  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapState({
    this.isMapInitized = false,
    this.isFollowingUser = false,
    this.showMyRoute = false,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : polylines = polylines ?? const {},
        markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitized,
    bool? isFollowingUser,
    Map<String, Polyline>? polylines,
    bool? showMyRoute,
Map<String, Marker>? markers,
  }) {
    return MapState(
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
      isMapInitized: isMapInitized ?? this.isMapInitized,
      showMyRoute: showMyRoute ?? this.showMyRoute,
      polylines: polylines ?? this.polylines,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object> get props => [
        polylines,
        isMapInitized,
        isFollowingUser,
        showMyRoute,
        markers,
      ];
}
