import 'package:e_commerce_food_app/controllers/cart_controller.dart';
import 'package:e_commerce_food_app/controllers/popular_product_controller.dart';
import 'package:e_commerce_food_app/models/product_model.dart';
import 'package:e_commerce_food_app/routes/route_helper.dart';
import 'package:e_commerce_food_app/utils/app_const.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/dimensions.dart';
import 'package:e_commerce_food_app/widgets/app_column.dart';
import 'package:e_commerce_food_app/widgets/app_icon.dart';
import 'package:e_commerce_food_app/widgets/big_text.dart';
import 'package:e_commerce_food_app/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;

  const PopularFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PopularProductController>();
    final cartController = Get.find<CartController>();
    var product = controller.popularProductList[pageId] as ProductModel;
    controller.initProduct(cartController, product);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimension.popularFoodImgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "${AppConst.BASE_URL}${AppConst.UPLOAD_URL}${product.img}"),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            top: 45,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.initial),
                    child: AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(
                  builder: (controller) => Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      controller.totalItems > 1
                          ? const Positioned(
                              top: 0,
                              right: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      controller.totalItems > 1
                          ? Positioned(
                              top: 3,
                              right: 3,
                              child: BigText(
                                text: controller.totalItems.toString(),
                                size: 12,
                                color: Colors.white,
                              ))
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimension.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimension.radius20),
                    topLeft: Radius.circular(Dimension.radius20),
                  ),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: 20),
                  BigText(text: "Introduce"),
                  SizedBox(height: 20),
                  Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableText(text: product.description!)))
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) => Container(
          height: Dimension.bottomHeightBar,
          padding: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimension.radius20 * 2),
                topRight: Radius.circular(Dimension.radius20 * 2),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => controller.setQuantity(false),
                        child: const Icon(Icons.remove,
                            color: AppColors.signColor)),
                    const SizedBox(width: 5),
                    BigText(text: controller.inCartItems.toString()),
                    const SizedBox(width: 5),
                    GestureDetector(
                        onTap: () => controller.setQuantity(true),
                        child:
                            const Icon(Icons.add, color: AppColors.signColor)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: AppColors.mainColor,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.addItem(product),
                      child: BigText(
                        text: "\$${product.price} | Add to cart",
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
