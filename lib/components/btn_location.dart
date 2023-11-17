import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/location/location_bloc.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';

class BtnLocation extends StatelessWidget {
  final LocationState state;
  const BtnLocation({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      right: 15,
      child: SafeArea(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              final mapBloc = BlocProvider.of<MapBloc>(context);

              mapBloc.moveCamara(state.lastLocation);
            },
          ),
        ),
      ),
    );
  }
}
