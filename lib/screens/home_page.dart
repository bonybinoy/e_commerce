import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/screens/chat_assistant_page.dart';
import 'package:e_commerce/screens/detail_page.dart';
import 'package:e_commerce/screens/settings_page.dart';
import 'package:e_commerce/widget/icon_widget.dart';
import 'package:e_commerce/widget/image_widget.dart';
import 'package:e_commerce/models/product_response_model.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Widget> imgList = [

  Image.asset("assets/images/logoo.jpg", fit: BoxFit.fill),
  Image.asset("assets/images/img.jpg", fit: BoxFit.fill),
  Image.asset("assets/images/img1.jpg", fit: BoxFit.fill),
  Image.asset("assets/images/img2.jpg", fit: BoxFit.fill),
  Image.asset("assets/images/img3.jpg", fit: BoxFit.fill),
  Image.asset("assets/images/img4.jpg", fit: BoxFit.fill),
  Image.asset("assets/images/img5.jpg", fit: BoxFit.fill),
];
List<CategoryModel> catList = [
  CategoryModel(category: "Phone"),
  CategoryModel(category: "Laptop"),
  CategoryModel(category: "Watch"),
  CategoryModel(category: "Footwear"),
  CategoryModel(category: "Cosmetics"),
];

int pageIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductResponseModel? productResponseModel;
  final TextEditingController searchController = TextEditingController();
  final dio = Dio();
  bool isLoading = true;

  Future<void> getProductData({String? searchItem}) async {
    setState(() {
      isLoading = true;
    });
    final response = await dio.get(
      'https://dummyjson.com/products/search',
      queryParameters: {"q": searchItem ?? ""},
    );
    if (response.statusCode == 200) {
      productResponseModel = ProductResponseModel.fromJson(response.data);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProductData();
    searchController.addListener(() {
      getProductData(searchItem: searchController.text);
    });
  }

  int? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20,),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: "LUXECART",
                      size: 20,
                      // weight: FontWeight.bold,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_rounded),
                      onPressed: () {
                        // Navigate to the chat assistant page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChatAssistantPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: IconWidget(icon: Icons.search),
                  ),
                  labelText: "Search for products",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            productResponseModel?.products?.isEmpty ?? true
                ? SizedBox()
                : TextWidget(
              text: " Crazy Deals",
              size: 18,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            CarouselSlider(
              items: imgList,
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
              ),
            ),
            const SizedBox(height: 20),
            productResponseModel?.products?.isEmpty ?? true
                ? SizedBox()
                : TextWidget(
                    text: "  Related top picks for you",
                    size: 18,
                    weight: FontWeight.bold,
                  ),
            const SizedBox(height: 20),
            productResponseModel?.products?.isEmpty ?? true
                ? SizedBox()
                :
            isLoading
                ? const SpinKitCircle(
                    color: Colors.grey,
                    size: 50,
                  )
                : productResponseModel?.products?.isEmpty ?? true
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconWidget(
                            icon: Icons.warning,
                            color: Colors.red,
                          ),
                          TextWidget(
                            text: 'Item not found',
                            color: Colors.red,
                          ),
                        ],
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 4.0,
                        ),
                        padding: const EdgeInsets.all(0),
                        itemCount: productResponseModel!.products!.length,
                        itemBuilder: (context, index) {
                          final product =
                              productResponseModel?.products![index];
                          final String? imageUrl =
                              product?.images?.isNotEmpty == true
                                  ? product!.images![0]
                                  : null;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    isNavigatedFromHomePage: true,
                                    imgUrl: imageUrl,
                                    text: product?.title,
                                    details: product?.brand,
                                    price: product?.price?.toInt(),
                                    offer: product?.discountPercentage?.toInt(),
                                    rating: product?.rating?.toString(),
                                    index: index,
                                    description: product?.description,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        height: 150,
                                        child: Center(
                                          child: ImageWidget(
                                            imgUrl: imageUrl,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        width: 42,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${product?.rating}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            const IconWidget(
                                              icon: Icons.star,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      TextWidget(
                                        text: '${product?.brand ?? ''}',
                                        line: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      TextWidget(
                                        text: '${product?.title}',
                                        weight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 10),
                                      Row(
                                        children: [
                                          const IconWidget(
                                            icon: Icons.attach_money_outlined,
                                            size: 20,
                                          ),
                                          TextWidget(
                                            text: "${product?.price?.toInt()}",
                                            weight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const IconWidget(
                                            icon: Icons.arrow_downward,
                                            color: Colors.green,
                                          ),
                                          TextWidget(
                                            text:
                                                '${product?.discountPercentage?.toInt()}% off',
                                            color: Colors.green,
                                            weight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
