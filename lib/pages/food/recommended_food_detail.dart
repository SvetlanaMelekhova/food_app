import 'package:e_commerce_food_app/controllers/cart_controller.dart';
import 'package:e_commerce_food_app/controllers/popular_product_controller.dart';
import 'package:e_commerce_food_app/controllers/recommended_product_controller.dart';
import 'package:e_commerce_food_app/models/product_model.dart';
import 'package:e_commerce_food_app/routes/route_helper.dart';
import 'package:e_commerce_food_app/utils/app_const.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/dimensions.dart';
import 'package:e_commerce_food_app/widgets/app_icon.dart';
import 'package:e_commerce_food_app/widgets/big_text.dart';
import 'package:e_commerce_food_app/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;

  const RecommendedFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    final product = Get.find<RecommendedProductController>()
        .recommendedProductList[pageId] as ProductModel;
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.initial),
                    child: AppIcon(icon: Icons.clear)),
                //AppIcon(icon: Icons.shopping_cart_outlined),
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
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimension.radius20),
                          topRight: Radius.circular(Dimension.radius20))),
                  child: Center(
                      child: BigText(
                    text: product.name!,
                    size: Dimension.font26,
                  )),
                )),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "${AppConst.BASE_URL}${AppConst.UPLOAD_URL}${product.img}",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: ExpandableText(text: product.description!),
                )
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.setQuantity(false),
                    child: AppIcon(
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimension.iconSize24,
                    ),
                  ),
                  BigText(
                    text: " \$${product.price}  X  ${controller.inCartItems} ",
                    color: AppColors.mainBlackColor,
                    size: Dimension.font26,
                  ),
                  GestureDetector(
                    onTap: () => controller.setQuantity(true),
                    child: AppIcon(
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimension.iconSize24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimension.bottomHeightBar,
              padding:
                  EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
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
                        color: Colors.white),
                    child:
                        const Icon(Icons.favorite, color: AppColors.mainColor),
                  ),
                  GestureDetector(
                    onTap: () => controller.addItem(product),
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: Row(
                        children: [
                          BigText(
                              text:
                                  "\$${product.price! * (controller.inCartItems + 1)} | Add to cart",
                              color: Colors.white)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
