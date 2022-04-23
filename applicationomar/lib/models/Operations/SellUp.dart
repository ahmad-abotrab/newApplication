class SellUp {
  String idProduct;
  String nameProduct;
  int quantity;
  double unitPrice;
  double vat;
  SellUp({this.idProduct, this.nameProduct, this.quantity, this.unitPrice});
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['idProduct'] = this.idProduct;
    map['nameProduct'] = this.nameProduct;
    map['quantity'] = this.quantity;
    map['unitPrice'] = this.unitPrice;
    return map;
  }

  factory SellUp.fromJson(Map<String, dynamic> map) {
    return SellUp(
      idProduct: map['idProduct'],
      nameProduct: map['nameProduct'],
      quantity: map['quantity'],
      unitPrice: map['unitPrice'],
    );
  }
}
