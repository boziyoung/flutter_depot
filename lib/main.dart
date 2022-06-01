// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:depot/page/add_goods.dart';
import 'package:depot/page/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // 声明所有的页面
  // 注册路由表
    final  routes = {
        "/": (context, {arguments}) => const MyHomePage(title: "W_depot"),
        "/add_goods": (context, {arguments}) =>  AddGoods(code: arguments),
      };


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'W_depot'),
      // 默认界面
      initialRoute: '/',

      // 当页面跳转时进行参数处理
      onGenerateRoute: (RouteSettings settings){
        // 获取声明的路由页面函数
        var pageBuilder = routes[settings.name];
        if (pageBuilder != null){
          if (settings.arguments != null){
          // 创建路由页面并携带参数
          return MaterialPageRoute(
            builder: (context) => pageBuilder(context, arguments: settings.arguments));
        } else {
            return MaterialPageRoute(
                builder: (context) => pageBuilder(context));        }
        }
        return MaterialPageRoute(builder: (context) => const MyHomePage(title: "W_depot"));

      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // 扫描二维码
//   Future<String> ss() async {
//     var options = const ScanOptions(
//       strings: {
//         'cancel': "取消",
//         'flash_on': "闪光灯",
//         'flash_off': "关闭",
//       },
//       android: AndroidOptions(useAutoFocus: false)
//     );
//     // print("object");
//     var result = await BarcodeScanner.scan(options: options);
//     print(result.type);
//     print(result.rawContent);
//     print(result.format);
//     print(result.formatNote);
//     return result.rawContent;
//   }

//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//         appBar: AppBar(
          
//           title: Text(widget.title),
//         ),
//         body: Center(
//           child: Column(children: [
//             const SizedBox(
//               height: 50.0,
//             ),
//             TextButton.icon(
//                 onPressed: () {
//                   ss();
//                 },
//                 icon: const Icon(Icons.search),
//                 label: const Text("扫一扫"))
            
//           ]),
//         ));
//   }
// }
