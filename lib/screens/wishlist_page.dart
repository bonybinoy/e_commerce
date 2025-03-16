import 'package:e_commerce/screens/detail_page.dart';
import 'package:e_commerce/widget/appbar_widget.dart';
import 'package:e_commerce/widget/bottomnav_widget.dart';
import 'package:e_commerce/widget/icon_widget.dart';
import 'package:e_commerce/widget/image_widget.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:e_commerce/models/wish_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

int pageIndex = 1;

class WishlistPage extends StatefulWidget {
  final int? index;
  const WishlistPage({super.key, this.index});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late final Box<WishListModel> wishBox;
  bool isLoading = true;

  Future<void> getWishBox() async {
    wishBox = await Hive.openBox<WishListModel>('wishList');
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getWishBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppbarWidget(
          text: 'My WishList',
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishBox.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/Animation - 1729504579388.json',
                height: MediaQuery.of(context).size.height / 3.5),
            const TextWidget(text: "You haven't added any products yet"),
          ],
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
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
                itemCount: wishBox.length,
                itemBuilder: (context, index) {
                  final wishItem = wishBox.getAt(index);
                  if (wishItem == null) {
                    return const SizedBox.shrink();
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            isNavigatedFromHomePage: false,
                            index: index,
                            imgUrl: wishItem.imgUrl,
                            text: wishItem.text,
                            details: wishItem.details,
                            price: wishItem.price,
                            offer: wishItem.offer,
                            rating: wishItem.rating,
                            description: wishItem.description,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Remove"),
                                          content: const Text(
                                              "You haven't added any products yet?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors
                                                        .blue),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                "Confirm",
                                                style: TextStyle(
                                                    color: Colors
                                                        .red),
                                              ),
                                              onPressed: () {
                                                wishBox.deleteAt(index);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                    const BottomnavWidget(
                                                      index: 1,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context)
                                          .size
                                          .width /
                                          3.15,
                                    ),
                                    child: const IconWidget(
                                      icon: Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                child: ImageWidget(
                                  imgUrl: wishItem.imgUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextWidget(
                                text: wishItem.text.toString(),
                                weight: FontWeight.bold,
                                line: 2,
                              ),
                              TextWidget(
                                text: wishItem.details.toString(),
                                // weight: FontWeight.w300,
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextWidget(
                                text: '₹${wishItem.price.toString()}',
                                weight: FontWeight.w500,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

