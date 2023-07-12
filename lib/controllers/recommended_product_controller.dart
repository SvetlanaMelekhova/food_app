import 'package:e_commerce_food_app/data/repository/recommended_product_repo.dart';
import 'package:e_commerce_food_app/models/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo repo;

  RecommendedProductController({required this.repo});

  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await repo.getRecommendedProductList();
    print("getPopularProductList");
    print("response.statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      print(_recommendedProductList);
      _isLoaded = true;
      update();
    } else {}
  }
}
