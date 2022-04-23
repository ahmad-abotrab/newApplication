import '/models/Human/Human.dart';

class Customer extends Human {
  double totalAmount;
  double amountPaid;
  double remainingAmount;
  
  Customer({
    id,
    name,
    address,
    phone,
    mobile,
    age,
    email,
    this.totalAmount,
    this.amountPaid,
    this.remainingAmount,
  }) : super(
          id: id,
          name: name,
          address: address,
          phone: phone,
          mobile: mobile,
          age: age,
          email: email,
        );
  @override
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map = super.toJson();
    map['totalAmount'] = this.totalAmount;
    map['amountPaid'] = this.amountPaid;
    map['remainingAmount'] = this.remainingAmount;

    return map;
  }

  factory Customer.fromJson(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
      mobile: map['mobile'],
      age: map['age'],
      email: map['email'],
      totalAmount: map['totalAmount'],
      amountPaid: map['amountPaid'],
      remainingAmount: map['remainingAmount'],
    );
  }
}
