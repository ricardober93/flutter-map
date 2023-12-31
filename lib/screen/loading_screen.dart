import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/gps/gps_bloc.dart';
import 'package:maps_app/screen/map_screen.dart';
import 'package:maps_app/screen/screen.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          if (state.isReady) {
            return MapScreen();
          } else {
            return const GpsScreen();
          }
        },
      ),
    );
  }
}
