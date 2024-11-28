import 'dart:convert';

Gift giftFromJson(String str) => Gift.fromJson(json.decode(str));

String giftToJson(Gift data) => json.encode(data.toJson());

class Gift {
  int id;
  String title;
  String description;
  double price;
  String brand;
  String category;
  String thumbnail;
  bool pledge;

  Gift({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.brand,
    required this.category,
    required this.thumbnail,
    this.pledge = true,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
      };

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      brand: json["brand"],
      category: json["category"],
      thumbnail: json["thumbnail"],
    );}
}
