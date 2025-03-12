import 'package:e_commerce/widget/text_widget.dart';
import 'package:flutter/material.dart';

import 'icon_widget.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? color;
  final IconData? icon;
  final  BorderSide? side;
  const ButtonWidget({
    super.key,
    this.onPressed,
    required this.text,
    this.color,  this.icon, this.side,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.green),
              ),
            ),
            backgroundColor: const WidgetStatePropertyAll(Colors.green),
          ),
          onPressed:
            onPressed
          ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: text,
                  color: Colors.white,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
