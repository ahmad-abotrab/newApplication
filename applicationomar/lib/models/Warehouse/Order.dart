class Order {
  int id;
  String name;
  double price;
  int qty;
  dynamic totalprice;
  Order({this.name, this.price, this.qty, this.totalprice});
  Order copy({
    String name,
    String price,
    String qty,
    String totalprice,
  }) =>
      Order(
          name: name ?? this.name,
          price: price ?? this.price,
          qty: qty ?? this.qty,
          totalprice: totalprice ?? this.totalprice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price &&
          qty == other.qty &&
          totalprice == other.totalprice;

  @override
  int get hashCode =>
      name.hashCode ^ price.hashCode ^ qty.hashCode ^ totalprice.hashCode;
}
