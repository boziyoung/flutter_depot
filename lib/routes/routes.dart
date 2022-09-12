// abstract 定义一个抽象类， 该类不能被实例化
import 'package:get/get.dart';

import '../page/Home/homePage.dart';
import '../page/edit_add/detail.dart';

abstract class Routes {
  static const String homePage = '/';
  static String goodsDetail = '/:code/detail';

  /// 页面合集
  static final routePage = [
    GetPage(
        name: homePage,
        page: () => MyHomePage(),
        // 页面过渡的动画设计
        transition: Transition.fadeIn),
    GetPage(
        name: goodsDetail,
        page: () => GoodsDetailPage(),
        // 页面过渡的动画设计
        transition: Transition.fadeIn)
  ];
}
