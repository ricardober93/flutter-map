import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? _gpsServicesSubscription;

  GpsBloc()
      : super(const GpsState(isGpsEnabled: false, isGpsPermission: false)) {
    on<OnGpsPermission>((event, emit) => emit(GpsState(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermission: event.isGpsPermission)));

    _init();
  }

  Future<void> _init() async {
    final gpsState = await Future.wait([
      _checkStateGps(),
      _isPermissonGranted(),
    ]);

    add(OnGpsPermission(
        isGpsEnabled: gpsState[0], isGpsPermission: gpsState[1]));
  }

  Future<bool> _isPermissonGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkStateGps() async {
    final gpsEnabled = await geolocator.Geolocator.isLocationServiceEnabled();

    _gpsServicesSubscription =
        geolocator.Geolocator.getServiceStatusStream().listen((status) {
      if (status == geolocator.ServiceStatus.enabled) {
        add(const OnGpsPermission(isGpsEnabled: true, isGpsPermission: true));
      } else {
        // add(const OnGpsPermission(isGpsEnabled: false, isGpsPermission: false));
      }
    });

    return gpsEnabled;
  }

  @override
  Future<void> close() {
    _gpsServicesSubscription?.cancel();

    return super.close();
  }

  Future<void> askGpsPermission() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(OnGpsPermission(
            isGpsEnabled: state.isGpsEnabled, isGpsPermission: true));
        break;
      default:
        add(OnGpsPermission(
            isGpsEnabled: state.isGpsEnabled, isGpsPermission: false));
        openAppSettings();
        break;
    }
  }
}
