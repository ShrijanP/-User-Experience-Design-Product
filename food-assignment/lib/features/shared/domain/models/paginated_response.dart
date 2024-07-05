const int PER_PAGE_LIMIT = 20;

class PaginatedResponse<T> {
  final int totalCount;

  final int size;

  static const limit = PER_PAGE_LIMIT;

  final List<T> data;

  PaginatedResponse(
      {required this.totalCount, required this.size, required this.data});

  factory PaginatedResponse.fromJson(dynamic json, List<T> data,
          {Function(dynamic json)? fixture}) =>
      PaginatedResponse(
        totalCount: json['totalCount'] ?? 0,
        size: json['size'] ?? 0,
        data: data,
      );
  @override
  String toString() {
    return 'PaginatedResponse(total:$totalCount, skip:$size, data:${data.length})';
  }
}
