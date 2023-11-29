import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/bloc.dart';

class ManualMarket extends StatelessWidget {
  const ManualMarket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const _ManualMarketBody()
            : const SizedBox();
      },
    );
  }
}

class _ManualMarketBody extends StatelessWidget {
  const _ManualMarketBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 80, left: 20, child: _BtnBack()),
          Center(
            child: BounceInDown(
                from: 100,
                child:
                    const Icon(Icons.location_on, size: 50, color: Colors.red)),
          ),
          Positioned(
            bottom: 80,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                height: 50,
                onPressed: () {
                  //Confirmar ubicación
                },
                color: Colors.black,
                shape: const StadiumBorder(),
                child: const Text(
                  'Confirmar destino',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack();

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
              onPressed: () {
                BlocProvider.of<SearchBloc>(context)
                    .add(OnDeactivateManualMarker());
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black87))),
    );
  }
}
