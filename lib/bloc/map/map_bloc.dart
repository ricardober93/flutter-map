import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/location/location_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  StreamSubscription<LocationState>? _locationSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitilizaedEvent>(_mapInitized);

    on<OnFollowUserEvent>((event, emit) {
      emit(state.copyWith(isFollowingUser: event.isFollowingUser));
    });

    on<UserStatePolilyne>(_onPolyneNewPoint);

    on<OnToggleMyRouteEvent>((event, emit) {
      emit(state.copyWith(showMyRoute: !event.showMyRoute));
    });

    _locationSubscription = locationBloc.stream.listen((state) {
      if (state.routeHistory.length > 1) {
        add(UserStatePolilyne(state.routeHistory));
      }

      if (state.following) {
        moveCamara(state.lastLocation);
      }
    });
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }

  void _onPolyneNewPoint(UserStatePolilyne event, Emitter<MapState> emit) {
    final polylines = state.polylines;
    polylines['userState'] = Polyline(
      polylineId: const PolylineId('userState'),
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.points,
    );
    emit(state.copyWith(polylines: polylines));
  }

  void _mapInitized(OnMapInitilizaedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    emit(state.copyWith(isMapInitized: true));
  }

  moveCamara(LatLng destination) {
    var cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(target: destination, zoom: 15),
    );
    _mapController?.animateCamera(cameraUpdate);
  }
}
