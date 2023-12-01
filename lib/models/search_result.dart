import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancel;
  final bool manual;
  final LatLng? destination;

  SearchResult({
    required this.cancel,
    this.manual = false,
    this.destination,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      cancel: json['cancel'],
      manual: json['manual'],
    );
  }

  @override
  String toString() {
    return 'cancel: $cancel, manual: $manual';
  }
}
