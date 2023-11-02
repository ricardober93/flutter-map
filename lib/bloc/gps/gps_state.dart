part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermission;

  const GpsState({required this.isGpsEnabled, required this.isGpsPermission});

  get isReady => isGpsEnabled && isGpsPermission;

  copyWith({bool? isGpsEnabled, bool? isGpsPermission}) => GpsState(
      isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
      isGpsPermission: isGpsPermission ?? this.isGpsPermission);

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermission];
}
