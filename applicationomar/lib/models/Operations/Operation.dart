import '/models/Human/Employee.dart';

class Operations {
  String id; //
  String type; //name of this operation
  double value;
  DateTime date;
  Employee employee;

  Operations({
    this.id,
    this.type,
    this.value,
    this.date,
    this.employee,
  });

  Map<String, dynamic> toJson() {
    final map = Map<String, dynamic>();
    map['id'] = this.id;
    map['type'] = this.type;
    map['value'] = this.value;
    map['date'] = this.date;
    map['employee'] = this.employee;
    return map;
  }

  factory Operations.fromJson(Map<String, dynamic> map) {
    return Operations(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      value: map['value'],
      employee: map['employee'],
    );
  }
}
