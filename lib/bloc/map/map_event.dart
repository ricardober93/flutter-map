part of 'map_bloc.dart';

class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitilizaedEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitilizaedEvent(this.controller);
}

class OnFollowUserEvent extends MapEvent {
  final bool isFollowingUser;
  const OnFollowUserEvent({required this.isFollowingUser});
}

class UserStatePolilyne extends MapEvent {
  final List<LatLng> points;

  const UserStatePolilyne(this.points);

  @override
  List<Object> get props => [points];
}

class OnToggleMyRouteEvent extends MapEvent {
  final bool showMyRoute;

  const OnToggleMyRouteEvent({required this.showMyRoute});
}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  const DisplayPolylinesEvent(this.polylines, this.markers);
}


