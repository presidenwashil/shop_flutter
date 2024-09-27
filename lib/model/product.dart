import 'dart:ffi';

class Product {
  int id;
  String code;
  String name;
  Float price;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.code,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        price: json['price'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'price': price,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
  };
}
  

