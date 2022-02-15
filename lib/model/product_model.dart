class Product {
  String? id;
  double? price;
  String? name;
  String? description;

  Product({this.price, this.name, this.description});

  Product.fromMap(Map snapshot, String? id)
      : id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['description'] ?? '';

  toJson() {
    return {
      "price": price,
      "name": name,
      "description": description,
    };
  }
}
