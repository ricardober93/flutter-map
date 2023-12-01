import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/bloc.dart';
import 'package:maps_app/bloc/search/search_bloc.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    searchBloc.getPlacesbyQuery(query, locationBloc.state.lastLocation!);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;

        return ListView.separated(
            itemCount: places.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final place = places[index];
              return ListTile(
                leading: const Icon(
                  Icons.place,
                  color: Colors.black87,
                ),
                title: Text(place.text),
                subtitle: Text(place.placeName),
                onTap: () {
                  final result = SearchResult(
                      cancel: false,
                      manual: false,
                      destination: LatLng(place.center[1], place.center[0]));

                  searchBloc.add(OnNewHistoryEvents(place));
                  close(context, result);
                },
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {


    final history = BlocProvider.of<SearchBloc>(context).state.history;

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Colocar ubicación manualmente'),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        ...history
            .map((place) => ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(place.text),
                  subtitle: Text(place.placeName),
                  onTap: () {
                    final result = SearchResult(
                        cancel: false,
                        manual: false,
                        destination: LatLng(place.center[1], place.center[0]));

                    close(context, result);
                  },
                ))
            .toList()
      ],

    );
  }
}
