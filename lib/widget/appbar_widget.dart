import 'package:e_commerce/widget/text_widget.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  final String text;

  const AppbarWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      title: TextWidget(
        text: text,
        size: 20,
        weight: FontWeight.w400,
      ),
    );
  }
}
