import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDestination {
  final double distance;
  final double duration;
  final List<LatLng> points;

  RouteDestination({
    required this.distance,
    required this.duration,
    required this.points,
  });
}
