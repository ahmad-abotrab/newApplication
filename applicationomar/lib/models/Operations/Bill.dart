import 'Operation.dart';

class Bill extends Operations {
  String notes;

  Bill({id, type, value, date, this.notes})
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

  factory Bill.fromJson(Map<String, dynamic> map) {
    return Bill(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      value: map['value'],
      notes: map['notes'],
    );
  }
}
