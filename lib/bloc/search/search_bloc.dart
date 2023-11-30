import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TrafficServices trafficServices;
  SearchBloc({required this.trafficServices}) : super(const SearchState()) {
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

  Future<RouteDestination> getStartToEnd(LatLng start, LatLng end) async {
    final trafficResponse = await trafficServices.getCoorsStartEnd(start, end);

    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    final points = decodePolyline(geometry, accuracyExponent: 6);
    final latLngList = points
        .map((coor) => LatLng(coor[0].toDouble(), coor[1].toDouble()))
        .toList();

    return RouteDestination(
        points: latLngList, duration: duration, distance: distance);
  }
}
