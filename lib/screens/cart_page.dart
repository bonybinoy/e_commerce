import 'dart:ui';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/widget/appbar_widget.dart';
import 'package:e_commerce/widget/button_widget.dart';
import 'package:e_commerce/widget/icon_widget.dart';
import 'package:e_commerce/widget/image_widget.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_web/razorpay_web.dart';

class CartPage extends StatefulWidget {
  final String? imgUrl;
  final int? index;
  final String? text;
  final String? details;
  final int? price;

  const CartPage({
    super.key,
    this.imgUrl,
    this.text,
    this.details,
    this.price,
    this.index,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Razorpay razorpay;
  int pageIndex = 2;
  double _totalPrice = 0;
  late Box<CartModel> cartBox;
  bool isLoading = true;

  Future<void> _initializeCartBox() async {
    cartBox = await Hive.openBox<CartModel>('cart');
    _calculateTotalPrice();
    setState(() {
      isLoading = false;
    });
  }

  void _calculateTotalPrice() {
    _totalPrice = 0.0;
    for (int i = 0; i < cartBox.length; i++) {
      _totalPrice +=
          (cartBox.getAt(i)?.price ?? 0) * (cartBox.getAt(i)?.qty ?? 1);
    }
  }

  void _updateTotalPrice() {
    setState(() {
      _calculateTotalPrice();
    });
  }

  void errorHandler(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: TextWidget(
        text: response.message ?? 'Payment error',
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
    ));
  }

  void successHandler(PaymentSuccessResponse response) {
    cartBox.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const CartPage(),
      ),
    );
  }

  void externalWalletHandler(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: TextWidget(
        text: 'External wallet used: ${response.walletName}',
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
    ));
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_waeUUkXGdhnmoe",
      "amount": (_totalPrice * 0.18 + _totalPrice) * 100.toInt(),
      "name": "LUXECART",
      "description": "Payment for cart items",
      "timeout": "180",
      "currency": "INR",
      "prefill": {
        "contact": "",
        "email": "test@abc.com",
      }
    };
    razorpay.open(options);
  }

  @override
  void initState() {
    super.initState();
    _initializeCartBox();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorHandler);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successHandler);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppbarWidget(text: 'My Cart'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartBox.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/images/Animation - 1729504910594.json",
                        height: MediaQuery.of(context).size.height / 3.5,
                      ),
                      const TextWidget(text: 'Cart is empty'),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: cartBox.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = cartBox.getAt(index);
                                if (item == null)
                                  return const SizedBox.shrink();

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    height: MediaQuery.of(context).size.height /
                                        4.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 25),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: ImageWidget(
                                                        imgUrl: item.imgUrl),
                                                  ),
                                                ],
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextWidget(
                                                        text: item.text ?? '',
                                                        line: 2,
                                                      ),
                                                      TextWidget(
                                                        text:
                                                            '\$${item.price.roundToDouble()}',
                                                        size: 18,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (item.qty >
                                                                  1) {
                                                                setState(() {
                                                                  item.qty -= 1;
                                                                  cartBox.putAt(
                                                                      index,
                                                                      item);
                                                                  _updateTotalPrice();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              child:
                                                                  const IconWidget(
                                                                icon: Icons
                                                                    .remove,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextWidget(
                                                                text: item.qty
                                                                    .toString(),
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              const TextWidget(
                                                                  text: "Qty"),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                item.qty += 1;
                                                                cartBox.putAt(
                                                                    index,
                                                                    item);
                                                                _updateTotalPrice();
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              child:
                                                                  const IconWidget(
                                                                icon: Icons.add,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, bottom: 15),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text("Delete"),
                                                    content: const Text(
                                                        "Are you sure want to delete this item?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue)),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const TextWidget(
                                                          text: "Confirm",
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          cartBox
                                                              .deleteAt(index);
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {
                                                            _calculateTotalPrice();
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const IconWidget(
                                                icon: Icons.delete_outline),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // cartBox.isEmpty
                    //     ? const SizedBox()
                    //     : Padding(
                    //         padding: const EdgeInsets.only(bottom: 10),
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //               decoration: BoxDecoration(
                    //                 // border: Border.all(color: Colors.black),
                    //                 // borderRadius: BorderRadius.circular(12),
                    //               ),
                    //               child: ListTile(
                    //                 title: TextWidget(
                    //                   text: 'Total Amount: \$${(_totalPrice)}',
                    //                   size: 17,
                    //                 ),
                    //                 // subtitle: const TextWidget(
                    //                 //   text: 'Tap to see further details',
                    //                 //   weight: FontWeight.w300,
                    //                 // ),
                    //               ),
                    //             ),
                    //             // Add space between the tile and button
                    //             SizedBox(height: 20),
                    //             // Proceed button

                    //           ],
                    //         ),
                    //       ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 190,
                            // decoration: BoxDecoration(color: Colors.red),
                            child: ListTile(
                              title: TextWidget(
                                text: 'Total Amount: \$${(_totalPrice)}',
                                size: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ButtonWidget(
                              text: "Proceed to pay",
                              icon: Icons.lightbulb_outline,
                              onPressed: () {
                                openCheckout();
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
