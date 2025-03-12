import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel {
  @HiveField(0)
  final String imgUrl;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String? details;
  @HiveField(3)
  int qty;
  @HiveField(4)
  int counter;  // Added this field with HiveField(4)
  @HiveField(5)
  final int? offer;  // Corrected index to 5
  @HiveField(6)
  final int price;
  @HiveField(7)
  final String? rating;
  @HiveField(8)
  final String? star;
  @HiveField(9)
  final int index;

  // Constructor with default values
  @HiveField(10)
  CartModel({
    this.counter = 0,
    required this.imgUrl,
    required this.text,
    this.details,
    this.qty = 1,
    this.offer,
    required this.price,
    this.rating,
    required this.index,
    this.star,
  });
}
