import '/models/Operations/Operation.dart';

class Withraw extends Operations {
  String notes;
  Withraw({id, type, value, date, this.notes})
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

  factory Withraw.fromJson(Map<String, dynamic> map) {
    return Withraw(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      value: map['value'],
      notes: map['notes'],
    );
  }
}
