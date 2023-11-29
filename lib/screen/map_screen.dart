import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/location/location_bloc.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';

import 'package:maps_app/components/components.dart';
import 'package:maps_app/views/map_view.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc? locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc!.startFollow();
  }

  @override
  void dispose() {
    locationBloc!.stopFollow();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastLocation == null) {
            return const Center(
              child: Text('Espere por favor...'),
            );
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapstate) {
              Map<String, Polyline> polylines = Map.from(mapstate.polylines);
              if (mapstate.showMyRoute) {
                polylines['userState'] = Polyline(
                    polylineId: const PolylineId('userState'),
                    width: 4,
                    color: Colors.black87,
                    points: mapstate.polylines.values
                        .map((e) => e.points)
                        .expand((e) => e)
                        .toList());
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                        initLocation: locationState.lastLocation!,
                        polylines: polylines.values.toSet()),
                    BtnLocation(state: locationState),
                    const FollowUser(),
                    const BtnToogleRoute(),
                    const SearchBarWidget(),
                    const ManualMarket(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
