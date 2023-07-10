import 'package:e_commerce_food_app/data/api/api_client.dart';
import 'package:e_commerce_food_app/utils/app_const.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConst.POPULAR_PRODUCT_URI);
  }
}