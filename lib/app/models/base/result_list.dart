class ResultListFields {
  static const String items = 'items';
  static const String count = 'count';

  static const List<String> values = [
    items,
    count,
  ];
}

class ResultList<T> {
  final List<T> items;
  final int count;

  ResultList({
    required this.items,
    required this.count,
  });

  factory ResultList.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    final items = (json[ResultListFields.items] as List).map((item) => fromJsonT(item)).toList();
    final totalCount = json[ResultListFields.count] as int;
    return ResultList<T>(
      items: items,
      count: totalCount,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) => {
      ResultListFields.items: items.map((item) => toJsonT(item)).toList(),
      ResultListFields.count: count,
    };
}