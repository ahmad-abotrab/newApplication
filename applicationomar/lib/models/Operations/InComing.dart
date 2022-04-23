import '/models/Operations/Operation.dart';

class InCommingModel extends Operations {
  String notes;

  InCommingModel({id, type, value, date, this.notes})
      : super(
          id: id,
          type: type,
          date: date,
          value: value,
        );
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map = super.toJson();
    map['notes'] = this.notes;
    return map;
  }

  factory InCommingModel.fromJson(Map<String, dynamic> map) {
    return InCommingModel(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      value: map['value'],
      notes: map['notes'],
    );
  }
}
