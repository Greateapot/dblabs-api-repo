import 'dart:convert' show jsonDecode;

class Table {
  final List<String> columnNames;
  final List<List<dynamic>> rows;

  Table._({required this.columnNames, required this.rows})
      : assert(rows.every((element) => element.length == columnNames.length));

  factory Table.fromJson(List<String> columnNames, String source) => Table._(
        columnNames: columnNames,
        rows: List<List<dynamic>>.from(jsonDecode(source)),
      );

  @override
  String toString() =>
      "Table(columnNames: [${columnNames.join(", ")}], rows: [${rows.map((e) => e.join(", ")).map((e) => "[$e]").join(", ")}])";
}
