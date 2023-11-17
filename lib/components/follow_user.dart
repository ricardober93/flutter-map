import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';

class FollowUser extends StatelessWidget {
  const FollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Positioned(
      bottom: 15,
      right: 15,
      child: SafeArea(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(state.isFollowingUser
                    ? Icons.directions_run_rounded
                    : Icons.hail_rounded),
                onPressed: () {
                  mapBloc.add(const OnFollowUserEvent(isFollowingUser: true));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
