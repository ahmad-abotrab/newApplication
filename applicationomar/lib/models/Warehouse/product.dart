class Product {
  String id;
  String name;
  String companyName;
  String barCode;
  String qrCode;
  int minAmount;
  int allQuantity;
  String catagory;
  String subCategory;
  double price;
  int chosenQuantity;
  DateTime expirationDate;

  Product(
      {this.id,
      this.barCode,
      this.name,
      this.companyName,
      this.qrCode,
      this.minAmount,
      this.catagory,
      this.subCategory,
      this.price,
      this.allQuantity,
      this.chosenQuantity,
      this.expirationDate});

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map['id'] = this.id;
    map['name'] = this.name;
    map['barCode'] = this.barCode;
    map['qrCode'] = this.qrCode;
    map['companyName'] = this.companyName;
    map['catagory'] = this.catagory;
    map['subCategory'] = this.subCategory;
    map['price'] = this.price;
    map['allQuantity'] = this.allQuantity;
    map['chosenQuantity'] = this.chosenQuantity;
    map['expirationDate'] = this.expirationDate;
    return map;
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      barCode: map['barCode'],
      qrCode: map['qrCode'],
      companyName: map['companyName'],
      catagory: map['catagory'],
      subCategory: map['subCategory'],
      price: map['price'],
      allQuantity: map['allQuantity'],
      chosenQuantity: map['chosenQuantity'],
      expirationDate:map['expirationDate'],
    );
  }
}
