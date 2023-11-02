import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/gps/gps_bloc.dart';

class GpsScreen extends StatelessWidget {
  const GpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
        if (!state.isGpsEnabled && !state.isGpsPermission) {
          return const _EnableGpsMessage();
        } else {
          return const _AccessButton();
        }
      })),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Es necesario el GPS para usar esta App',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
        MaterialButton(
          color: Colors.black,
          shape: const StadiumBorder(),
          splashColor: Colors.transparent,
          onPressed: () {
            final gpsBloc = context.read<GpsBloc>();
            gpsBloc.askGpsPermission();
          },
          child: const Text(
            'Solictar el acceso',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Debe Actualzar su GPS',
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500));
  }
}
