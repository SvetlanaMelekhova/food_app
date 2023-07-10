import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/dimensions.dart';
import 'package:e_commerce_food_app/widgets/big_text.dart';
import 'package:e_commerce_food_app/widgets/small_text.dart';
import 'package:e_commerce_food_app/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimension.font26,),
        SizedBox(height: Dimension.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                    (index) => const Icon(Icons.star,
                    color: AppColors.mainColor, size: 18),
              ),
            ),
            const SizedBox(width: 10),
            const SmallText(text: "4.5"),
            const SizedBox(width: 10),
            const SmallText(text: "1287"),
            const SizedBox(width: 10),
            const SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimension.height20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWithIcon(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            TextWithIcon(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),
            TextWithIcon(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}