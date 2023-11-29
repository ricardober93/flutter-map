class SearchResult {
  final bool cancel;
  final bool manual;

  SearchResult({
    required this.cancel,
    this.manual = false,
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
