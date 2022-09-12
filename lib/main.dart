// import 'package:barcode_scan2/barcode_scan2.dart';
// import 'package:depot/page/edit_add/add_goods.dart';
// import 'package:depot/page/backend/AllGoodsList.dart';
// import 'package:depot/page/Home/homePage.dart';
// import 'package:depot/page/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/routes.dart';

void main() {
  // WidgetFlutterBinding 与 Flutter引擎交互的
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    // 默认界面
    initialRoute: '/',
    getPages: Routes.routePage,
    // debug 是否显示模式横幅
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    // home: MyHomePage(
    //   title: "test getx",
    // ),
  ));
}

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);

//   // 声明所有的页面
//   // 注册路由表
//   final routes = {
//     "/": (context, {arguments}) => const MyHomePage(title: "W_depot"),
//     "/add_goods": (context, {arguments}) => AddGoods(code: arguments),
//     "/login": (context, {arguments}) => const Login(),
//     "/userinfo": (context, {arguments}) => const DetailUserInfo()
//   };

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: const MyHomePage(title: 'W_depot'),
//       // 默认界面
//       initialRoute: '/',

//       // 当页面跳转时进行参数处理
//       onGenerateRoute: (RouteSettings settings) {
//         // 获取声明的路由页面函数
//         var pageBuilder = routes[settings.name];
//         if (pageBuilder != null) {
//           if (settings.arguments != null) {
//             // 创建路由页面并携带参数
//             return MaterialPageRoute(
//                 builder: (context) =>
//                     pageBuilder(context, arguments: settings.arguments));
//           } else {
//             return MaterialPageRoute(
//                 builder: (context) => pageBuilder(context));
//           }
//         }
//         return MaterialPageRoute(
//             builder: (context) => const MyHomePage(title: "W_depot"));
//       },
//     );
//   }
// }
