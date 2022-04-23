import '/models/Human/Customer.dart';
import '/models/Human/Employee.dart';
import '/models/Operations/Operation.dart';

import 'SellUp.dart';

class Sell extends Operations {
  Customer customer;
  Employee employee;
  List<SellUp> productsSell;
  String notes;

  Sell(
      {id,
      type,
      date,
      value,
      this.customer,
      this.employee,
      this.notes,
      this.productsSell})
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
    map['products'] = this.productsSell;
    map['customer'] = this.customer.toJson();
    map['employee'] = this.employee.toJson();

    return map;
  }

  factory Sell.fromJson(Map<String, dynamic> map) {
    return Sell(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      value: map['value'],
      notes: map['notes'],
      productsSell: map['products'],
      employee: map['employee'],
      customer: map['customer'],
    );
  }
}
