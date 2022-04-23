import 'Human.dart';

class Employee extends Human {
  int workHours; //working hours for employee
  double costOfEachHour; //cost Of Each Hour
  double salary;
  String career;
  String password;
  String pin;

  Employee(
      {id,
      name,
      address,
      phone,
      mobile,
      age,
      email,
      this.workHours,
      this.costOfEachHour,
      this.salary,
      this.career,
      this.password,
      this.pin})
      : super(
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
    map['workHours'] = workHours;
    map['costOfEachHour'] = this.costOfEachHour;
    map['salary'] = this.salary;
    map['career'] = this.career;
    map['password'] = this.password;
    map['pin'] = this.pin;
    return map;
  }

  factory Employee.fromJson(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
      mobile: map['mobile'],
      age: map['age'],
      email: map['email'],
      workHours: map['workHours'],
      costOfEachHour: map['costOfEachHour'],
      salary: map['salary'],
      career: map['career'],
      password: map['password'],
      pin: map['pin'],
    );
  }
}
