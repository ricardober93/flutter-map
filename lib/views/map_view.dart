import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/bloc.dart';

class MapView extends StatelessWidget {
  final LatLng initLocation;
  final Set<Polyline> polylines;
final Set<Marker> markers;

  const MapView(
      {super.key,
      required this.initLocation,
      required this.polylines,
      required this.markers});

  @override
  Widget build(BuildContext context) {
    final mapController = BlocProvider.of<MapBloc>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (event) =>
            mapController.add(const OnFollowUserEvent(isFollowingUser: false)),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initLocation,
            zoom: 15,
          ),
          myLocationEnabled: true,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          polylines: polylines,
          markers: markers,
          onMapCreated: (controller) =>
              mapController.add(OnMapInitilizaedEvent(controller)),
          onCameraMove: (position) => mapController.mapCenter = position.target,
        ),
      ),
    );
  }
}
