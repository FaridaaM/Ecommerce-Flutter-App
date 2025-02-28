class ProductCartModel {
  String? id;
  String? title;
  num? price;
  String? description;
  String? image;
  int? quantity;

  ProductCartModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.image,
    this.quantity,
  });

  ProductCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['quantity'] = quantity; // ✅ Fixed this line
    data['image'] = image;
    return data;
  }
}
