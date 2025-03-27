class TableModel {
  bool active;
  int column;
  String id;
  int number;
  int row;
  String shape;
  String size;

  TableModel({
    required this.active,
    required this.column,
    required this.id,
    required this.number,
    required this.row,
    required this.shape,
    required this.size,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      active: json['active'] as bool,
      column: json['column'] as int,
      id: json['id'] as String,
      number: json['number'] as int,
      row: json['row'] as int,
      shape: json['shape'] as String,
      size: json['size'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'column': column,
      'id': id,
      'number': number,
      'row': row,
      'shape': shape,
      'size': size,
    };
  }
}