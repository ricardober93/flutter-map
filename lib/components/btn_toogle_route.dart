import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';

class BtnToogleRoute extends StatelessWidget {
  const BtnToogleRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Positioned(
      bottom: 75,
      right: 15,
      child: SafeArea(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              mapBloc.add(
                  OnToggleMyRouteEvent(showMyRoute: mapBloc.state.showMyRoute));
            },
          ),
        ),
      ),
    );
  }
}
