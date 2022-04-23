import '/models/Human/Customer.dart';

class Debts {//
  double value;//
  Customer customer;
  DateTime date;

  Debts({this.value, this.customer, this.date});
    Map<String, dynamic> toJson() {
    final map = Map<String, dynamic>();
    map['id'] = this.value;
    map['customer'] = this.customer.toJson();
    map['address'] = this.date;

    return map;
  }

  factory Debts.fromMap(Map<String, dynamic> map) {
    return Debts(
      value: map['amount'],
      date: DateTime.parse(map['name']),
      customer: map['customer'],

    );
  }

}
