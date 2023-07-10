import 'package:e_commerce_food_app/utils/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overflow;

  const BigText({
    super.key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 20,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size == 0 ? Dimension.font20 : size,
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto'),
      overflow: overflow,
      maxLines: 1,
    );
  }
}
