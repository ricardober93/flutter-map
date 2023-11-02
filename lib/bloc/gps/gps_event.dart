part of 'gps_bloc.dart';

sealed class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class OnGpsPermission extends GpsEvent {
  final bool isGpsPermission;
  final bool isGpsEnabled;

  const OnGpsPermission(
      {required this.isGpsPermission, required this.isGpsEnabled});
}
