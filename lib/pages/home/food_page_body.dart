import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_food_app/utils/colors.dart';
import 'package:e_commerce_food_app/utils/dimensions.dart';
import 'package:e_commerce_food_app/widgets/app_column.dart';
import 'package:e_commerce_food_app/widgets/big_text.dart';
import 'package:e_commerce_food_app/widgets/small_text.dart';
import 'package:e_commerce_food_app/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  final PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimension.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        print("Current value is ${_currPageValue}");
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //color: Colors.red,
          height: Dimension.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(height: Dimension.height30),
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BigText(text: "Popular"),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: const BigText(text: ".", color: Colors.black26),
              ),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: const SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(
                left: 20, right: 20, bottom: Dimension.height10),
            child: Row(
              children: [
                Container(
                  height: Dimension.listViewImgSize,
                  width: Dimension.listViewImgSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    color: Colors.white38,
                    image: const DecorationImage(
                        image: AssetImage("assets/image/food0.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: Dimension.listViewTextSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimension.radius20),
                        bottomRight: Radius.circular(Dimension.radius20),
                      ),
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "Nutrition fruit meal in China"),
                          SmallText(text: "With chinese characteristics"),
                          Row(
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
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimension.pageViewContainer,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimension.radius30),
              color: const Color(0xff69c5df),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/food0.png")),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimension.height15, left: 15, right: 15),
                child: AppColumn(text: "Chinese Side")
              ),
            ),
          ),
        ],
      ),
    );
  }
}
