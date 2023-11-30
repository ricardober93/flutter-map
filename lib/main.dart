import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/bloc.dart';
import 'package:maps_app/screen/screen.dart';
import 'package:maps_app/services/services.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => GpsBloc()),
    BlocProvider(create: (context) => LocationBloc()),
    BlocProvider(
        create: (context) =>
            MapBloc(locationBloc: context.read<LocationBloc>())),
    BlocProvider(
        create: (context) => SearchBloc(trafficServices: TrafficServices()))
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Maps',
      home: LoadingScreen(),
    );
  }
}
