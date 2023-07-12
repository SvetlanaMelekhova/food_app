import 'package:e_commerce_food_app/controllers/cart_controller.dart';
import 'package:e_commerce_food_app/data/repository/popular_product_repo.dart';
import 'package:e_commerce_food_app/models/product_model.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo repo;

  PopularProductController({required this.repo});

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await repo.getPopularProductList();
    print("getPopularProductList");
    print("response.statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _checkQuantity(_quantity + 1);
    } else {
      _quantity = _checkQuantity(_quantity - 1);
    }
    update();
  }

  int _checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    }
    if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item count", "You can't add more!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    }
    return quantity;
  }

  void initProduct(CartController cartController, ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cartController;
    var exist = false;
    exist = _cart.existInCart(product);
    print("exist or not $exist");
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("The quantity in the cart is $_inCartItems");
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The id is ${value.id}. The quantity is ${value.quantity}");
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }
}
