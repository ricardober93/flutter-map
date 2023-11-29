import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/bloc.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return !state.displayManualMarker
            ? const _SearchBarCustomBody()
            : const SizedBox();
      },
    );
  }
}

class _SearchBarCustomBody extends StatelessWidget {
  const _SearchBarCustomBody({Key? key}) : super(key: key);

  void _onSearchResult(BuildContext context, SearchResult result) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    if (result.manual) {
      searchBloc.add(OnActivateManualMarker());
      return;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 300),
      child: Positioned(
        top: 0,
        left: 0,
        child: SafeArea(
          child: GestureDetector(
            onTap: () async {
              final result = await showSearch(
                  context: context, delegate: SearchDestinationDelegate());
              if (result == null) return;

              _onSearchResult(context, result);
            },
            child: Container(
                alignment: Alignment.centerLeft,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width - 50,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Text('A donde quieres ir ?')),
          ),
        ),
      ),
    );
  }
}
