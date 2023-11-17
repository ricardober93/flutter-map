import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/bloc.dart';

class MapView extends StatelessWidget {
  final LatLng initLocation;
  final Set<Polyline> polylines;

  const MapView(
      {super.key, required this.initLocation, required this.polylines});

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
          onMapCreated: (controller) =>
              mapController.add(OnMapInitilizaedEvent(controller)),
        ),
      ),
    );
  }
}
