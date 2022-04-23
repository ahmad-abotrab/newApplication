class Human {
  String id; //id
  String name; //name of human ,type should be var char
  String address; //where is live , should be var char
  String phone; // and maybe number
  String mobile; // and maybe number
  int age; // should be var char
  String email; // should be var char

  Human({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.mobile,
    this.age,
    this.email,
  });

  Map<String, dynamic> toJson() {
    final map = Map<String, dynamic>();
    map['id'] = this.id;
    map['name'] = this.name;
    map['address'] = this.address;
    map['phone'] = this.phone;
    map['mobile'] = this.mobile;
    map['age'] = this.age;
    map['email'] = this.email;
    return map;
  }

  factory Human.fromMap(Map<String, dynamic> map) {
    return Human(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
      mobile: map['mobile'],
      age: map['age'],
      email: map['email'],
    );
  }
}
