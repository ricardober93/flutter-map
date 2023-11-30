import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/location/location_bloc.dart';
import 'package:maps_app/models/models.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? _locationSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitilizaedEvent>(_mapInitized);

    on<OnFollowUserEvent>((event, emit) {
      emit(state.copyWith(isFollowingUser: event.isFollowingUser));
      if (locationBloc.state.lastLocation == null) return;
      moveCamara(locationBloc.state.lastLocation!);
    });

    on<UserStatePolilyne>(_onPolyneNewPoint);

    on<OnToggleMyRouteEvent>((event, emit) {
      emit(state.copyWith(showMyRoute: !event.showMyRoute));
    });

    on<DisplayPolylinesEvent>((event, emit) {
      emit(state.copyWith(polylines: event.polylines));
    });

    _locationSubscription = locationBloc.stream.listen((state) {
      if (state.routeHistory.length > 1) {
        add(UserStatePolilyne(state.routeHistory));
      }

      if (!state.following) return;
      if (state.lastLocation == null) return;
      moveCamara(state.lastLocation!);
    });
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }

  void _onPolyneNewPoint(UserStatePolilyne event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.points);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void _mapInitized(OnMapInitilizaedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    emit(state.copyWith(isMapInitized: true));
  }

  Future drawRoutePolyline(RouteDestination route) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: route.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    final curretPolylines = Map<String, Polyline>.from(state.polylines);
    curretPolylines['route'] = myRoute;

    add(DisplayPolylinesEvent(curretPolylines));
  }

  moveCamara(LatLng destination) {
    var cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(target: destination, zoom: 15),
    );
    _mapController?.animateCamera(cameraUpdate);
  }
}
