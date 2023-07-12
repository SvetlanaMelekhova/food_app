import 'package:e_commerce_food_app/controllers/cart_controller.dart';
import 'package:e_commerce_food_app/controllers/popular_product_controller.dart';
import 'package:e_commerce_food_app/controllers/recommended_product_controller.dart';
import 'package:e_commerce_food_app/data/api/api_client.dart';
import 'package:e_commerce_food_app/data/repository/popular_product_repo.dart';
import 'package:e_commerce_food_app/data/repository/recommended_product_repo.dart';
import 'package:e_commerce_food_app/utils/app_const.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //apis
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConst.BASE_URL));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(repo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(repo: Get.find()));
  Get.lazyPut(() => CartController(repo: Get.find()));
}
