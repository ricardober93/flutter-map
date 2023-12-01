import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

class TrafficServices {
  final Dio _dioTraffic;
  final Dio _geoQuery;

  final _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';

  final _queryUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  TrafficServices() 
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _geoQuery = Dio()..interceptors.add(PlacesInterceptor());
  

  Future<TrafficResponse> getCoorsStartEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';

    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromJson(resp.data);

    return data;
  }

  Future<List<Feature>> getResultsQuery(LatLng proximity, String search) async {
    if (search.isEmpty) return [];

    final url = '$_queryUrl/$search.json';

    final resp = await _geoQuery.get(url, queryParameters: {
      'proximity': '${proximity.longitude},${proximity.latitude}'
    });

    final data = PlacesResponse.fromJson(resp.data);

    return data.features;
  }
}
