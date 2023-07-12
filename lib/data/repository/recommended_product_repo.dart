import 'package:e_commerce_food_app/data/api/api_client.dart';
import 'package:e_commerce_food_app/utils/app_const.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConst.RECOMMENDED_PRODUCT_URI);
  }
}
