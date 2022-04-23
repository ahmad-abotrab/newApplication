import 'dart:convert';

import '../../models/Human/Employee.dart';
import '../../models/Operations/Operation.dart';

class Salary extends Operations {
  Employee employee;
  Salary({id, type, value, date, this.employee})
      : super(
          id: id,
          date: date,
          value: value,
          type: type,
        );
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map = super.toJson();
    map['emplyee'] = this.employee.toJson();
    return map;
  }

  factory Salary.fromJson(Map<String, dynamic> map) {
    return Salary(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      value: map['value'],
      employee: Employee.fromJson(jsonDecode(map['employee'])),
    );
  }
}
