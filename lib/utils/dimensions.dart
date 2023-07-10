import 'package:get/get.dart';

class Dimension {
  static final double screenHeight = Get.context!.height;
  static final double screenWidth = Get.context!.width;

  //844/220 = 3.84
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 6.73;
  static double pageView = screenHeight / 2.64;

  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;

  static double width10 = screenWidth / 84.4;
  static double width15 = screenWidth / 56.27;
  static double width20 = screenWidth / 42.2;

  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;


  static double listViewImgSize = screenWidth / 3.25;
  static double popularFoodImgSize = screenHeight / 2.41;

  static double listViewTextSize = screenWidth / 3.9;

  static double bottomHeightBar = screenHeight / 7.03;


  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  static double scaleHeight(double h) {
    double y = 844.0 / h;
    return screenHeight / y;
  }

  static double scaleWidth(double w) {
    double y = 410.0 / w;
    return screenWidth / y;
  }
}
