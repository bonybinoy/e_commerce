import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/widget/button_widget.dart';
import 'package:e_commerce/widget/icon_widget.dart';
import 'package:e_commerce/widget/image_widget.dart';
import 'package:e_commerce/models/product_response_model.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:e_commerce/models/wish_list_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ProductResponseModel? productResponseModel;

class DetailPage extends StatefulWidget {
  final String? imgUrl;
  final String? text;
  final String? description;
  final String? details;
  final String? rating;
  final int? offer;
  final int? price;
  final bool? isNavigatedFromHomePage;
  final int index;

  const DetailPage({
    super.key,
    required this.index,
    required this.imgUrl,
    this.text,
    this.details,
    this.rating,
    this.offer,
    this.price,
    this.isNavigatedFromHomePage,
    this.description,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Box<WishListModel> wishBox;
  late Box<CartModel> cartBox;
  bool isAddToCart = false;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    declareBoxes();
  }

  Future<void> declareBoxes() async {
    cartBox = await Hive.openBox<CartModel>('cart');
    wishBox = await Hive.openBox<WishListModel>('wishlist');

    setState(() {
      isLiked = wishBox.containsKey(widget.text);
      isAddToCart =
          cartBox.containsKey(widget.text);
    });
  }

  void _toggleCart() {
    setState(() {
      if (isAddToCart) {
        cartBox.delete(widget.text);
        isAddToCart = false;
      } else {
        cartBox.put(
          widget.text,
          CartModel(
            index: widget.index,
            imgUrl: '${widget.imgUrl}',
            text: '${widget.text}',
            price: widget.price!.toInt(),
          ),
        );
        isAddToCart = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: TextWidget(
          color: Colors.white,
          text: isAddToCart
              ? '${widget.text} added to cart!'
              : '${widget.text} removed from cart!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.black,
        title: const TextWidget(
          text: 'Detail Page',
          size: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Center(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.2,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: ImageWidget(
                      imgUrl: '${widget.imgUrl}',
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isLiked) {
                            wishBox.delete(widget.text);
                            isLiked = false;
                          } else {
                            wishBox.put(
                              widget.text,
                              WishListModel(
                                index: widget.index,
                                rating: '${widget.rating}',
                                description: '${widget.description}',
                                imgUrl: '${widget.imgUrl}',
                                text: '${widget.text}',
                                details: '${widget.details}',
                                price: widget.price,
                                offer: widget.offer,
                              ),
                            );
                            isLiked = true;
                          }
                        });
                        CherryToast(
                          icon: isLiked
                              ? Icons.favorite
                              : Icons.heart_broken_sharp,
                          iconColor: Colors.red,
                          themeColor: Colors.red,
                          description: Text(
                            isLiked
                                ? '${widget.text} added to Wishlist!'
                                : '${widget.text} removed from Wishlist!',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          toastPosition: Position.bottom,
                          animationDuration: const Duration(milliseconds: 1000),
                          autoDismiss: true,
                        ).show(context);
                      },
                      child: Row(
                        children: [
                          IconWidget(
                            icon: isLiked
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: isLiked ? Colors.red : Colors.red,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    text: '${widget.text}',
                    weight: FontWeight.w500,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextWidget(
                text: '${widget.details}',
                weight: FontWeight.w400,
                size: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: TextWidget(
                text: '${widget.description}',
                size: 13,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 40,
                color: Colors.green.withOpacity(0.2),
                child: Row(
                  children: [
                    const IconWidget(
                      icon: Icons.arrow_downward,
                      color: Colors.green,
                    ),
                    TextWidget(
                      text: '${widget.offer}% off',
                      color: Colors.green,
                      size: 20,
                      weight: FontWeight.w500,
                    ),
                    const SizedBox(width: 10),
                    TextWidget(
                      text: '\$${widget.price?.toInt()}',
                      weight: FontWeight.w500,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              onPressed: _toggleCart,
              text: isAddToCart ? 'Added to cart' : 'Add to cart',
              icon: isAddToCart
                  ? Icons.check_circle_outline
                  : Icons.shopping_cart_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
