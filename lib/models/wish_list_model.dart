import 'package:hive/hive.dart';

part 'wish_list_model.g.dart';

@HiveType(typeId: 2)
class WishListModel {
  @HiveField(0)
  final String imgUrl;
  @HiveField(1)
  final int? index;
  @HiveField(2)
  final String? text;
  @HiveField(3)
  final String? details;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final int? offer;
  @HiveField(6)
  final int? offerPrice;
  @HiveField(7)
  final int? price;
  @HiveField(8)
  final String? rating;
  @HiveField(9)
  final String? star;
  @HiveField(10)
  final String? people;

  // Constructor should be at the end of the fields
  WishListModel({
    required this.imgUrl,
    this.index,
    this.text,
    this.details,
    this.description,
    this.offer,
    this.offerPrice,
    this.price,
    this.rating,
    this.star,
    this.people,
  });
}
