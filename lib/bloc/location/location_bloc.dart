import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? positionStream;

  LocationBloc() : super(const LocationState(lastLocation: LatLng(0, 0))) {
    on<OnLocationUpdate>((event, emit) {
      emit(state.copyWith(
        lastLocation: event.lastLocation,
        routeHistory: [...state.routeHistory, event.lastLocation],
      ));
    });

    on<OnStartFollowUser>((event, emit) => emit(state.copyWith(
          following: true,
        )));

    on<OnStopFlowing>((event, emit) => emit(state.copyWith(
          following: false,
        )));
  }

  Future<void> getCurrentPosition() async {
    await Geolocator.getCurrentPosition();
  }

  void startFollow() {
    add(OnStartFollowUser());
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      add(OnLocationUpdate(LatLng(position.latitude, position.longitude)));
    });
  }

  @override
  Future<void> close() {
    stopFollow();
    return super.close();
  }

  void stopFollow() {
    add(OnStopFlowing());
    positionStream?.cancel();
  }
}
