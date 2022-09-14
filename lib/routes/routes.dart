// abstract 定义一个抽象类， 该类不能被实例化
import 'package:get/get.dart';

import '../page/Home/homePage.dart';
import '../page/backend/AllGoodsList.dart';
import '../page/edit_add/detail.dart';
import '../page/login/login.dart';

abstract class Routes {
  static const String homePage = '/';
  static String goodsDetail = '/:code/detail';
  static const String login = '/login';
  static const String back = '/goodslist';

  /// 页面合集
  static final routePage = [
    GetPage(
        name: homePage,
        page: () => MyHomePage(),
        // 页面过渡的动画设计
        transition: Transition.fadeIn),
    GetPage(
        name: back,
        page: () => GoodsListPage(),
        // 页面过渡的动画设计
        transition: Transition.fadeIn),
    GetPage(
        name: login,
        page: () => LoginPage(),
        // 页面过渡的动画设计
        transition: Transition.fadeIn),
    GetPage(
        name: goodsDetail,
        page: () => GoodsDetailPage(),
        // 页面过渡的动画设计
        transition: Transition.fadeIn)
  ];
}
