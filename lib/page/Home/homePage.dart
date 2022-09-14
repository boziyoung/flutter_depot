// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:depot/common/rootbar.dart';
import 'package:depot/page/login/login.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../backend/AllGoodsList.dart';
import 'homeController.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  HomeController hc = Get.put(HomeController());
  // 输入框编辑器控制器
  TextEditingController vc = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(context),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
                onPressed: () async {
                  // hc.getGoodsPrices("12312312");
                  // Get.toNamed('/12312311/detail');
                  var code = await hc.qs();
                  print("code: $code");
                  Get.toNamed("/$code/detail");
                },
                icon: const Icon(Icons.search),
                label: const Text("扫一扫")),
            TextButton(
                onPressed: () {
                  print("文本输入查询");
                  Get.defaultDialog(
                    title: "输入您需要添加商品的Code码",
                    titleStyle: const TextStyle(color: Colors.blue),
                    content: TextField(
                      // 设定键盘输入类型
                      keyboardType: TextInputType.number,
                      // 验证输入格式
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
                      decoration: const InputDecoration(
                          labelText: "Code",
                          hintText: "商品Code码是系统中唯一值",
                          prefixIcon: Icon(Icons.info)),
                      // 获取输入数据内容 通过 controller 获取
                      controller: vc,
                    ),
                    onConfirm: () {
                      Get.offAllNamed("/${vc.text}/detail");
                      // print(vc.text);
                      // 删除 该商品后弹框 消失 回到 商品列表页面
                    },
                    onCancel: () {
                      // 清空输入框
                      vc.text = "";
                    },
                    textCancel: "取消",
                    textConfirm: "确认",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.black,
                    // 可自定义 cancel 和 confirm 按钮
                    // 自定义 cancel  confirm  上面的各个按钮设置属性可以重新在 cancel 的 button 中显示
                    // backgroundColor: Colors.grey.withOpacity(.5),

                    barrierDismissible: false, // 点击其他地方，alert 不会消失
                    radius: 10.0, // 圆角
                  );
                },
                child: const Text("文本输入查询")),
            TextButton(
                onPressed: () {
                  Get.to(GoodsListPage());
                },
                child: Text("list"))
          ],
        ),
      ),
      bottomNavigationBar: BottonBar(context),
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
  // goods info
//   // final goodsInfo = [];

//   // 扫描二维码
//   Future<String> ss() async {
//     var options = const ScanOptions(strings: {
//       'cancel': "取消",
//       'flash_on': "闪光灯",
//       'flash_off': "关闭",
//     }, android: AndroidOptions(useAutoFocus: false));
//     // print("object");
//     var result = await BarcodeScanner.scan(options: options);
//     print(result.type);
//     print(result.rawContent);
//     print(result.format);
//     print(result.formatNote);
//     return result.rawContent;
//   }

//   // 查询 价格
//   Future<dynamic> getPrices(String code) async {
//     String url = "http://139.155.16.210:8000/depot/$code/get_code/";
//     print("路径：" + url);
//     Dio dio = Dio();
//     try {
//       Response _rep = await dio.get(url);
//       print(_rep.data[0]);
//       // return _rep.statusCode.toString();
//       if (_rep.statusCode.toString() == "200") {
//         return _rep.data;
//       }
//     } on Exception catch (e) {
//       return "404";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         // 添加底部导航栏
//         bottomNavigationBar: BottonBar(context),
//         floatingActionButtonLocation:
//             FloatingActionButtonLocation.centerDocked, // 设置float button 的显示位置
//         floatingActionButton: IconButton(
//             color: Colors.blue, // 按钮icon的颜色
//             // splashColor: Colors.blue,  // 一闪而过的 背景颜色
//             // highlightColor: Colors.blue,  // 点击时的背景颜色
//             onPressed: (() async {
//               var code = await ss();
//               print("code" + code.runtimeType.toString());
//               Map map = {"code": code};
//               // var code1 = "12121";
//               Navigator.pushNamed(context, '/add_goods', arguments: {
//                 "code": map,
//               });
//               // Navigator.push(context, MaterialPageRoute(
//               //                               builder: (context) => AddGoods(code: code)));
//             }),
//             icon: const Icon(Icons.add)),
//         body: Center(
//           child: Column(children: [
//             const SizedBox(
//               height: 50.0,
//             ),
//             TextButton.icon(
//                 onPressed: () async {
//                   var code = await ss();
//                   print("扫一扫：" + code);
//                   var sc = await getPrices(code);
//                   print("状态码: " + sc.toString());
//                   print(sc[0]);
//                   print(sc[0]["test"]);
//                   Navigator.pushNamed(context, "/add_goods",
//                       arguments: {"code": sc[0]});
//                   // Navigator.pushNamed(context, "/add_goods", arguments: {
//                   //   "code": goodsInfo[0],
//                   // });
//                 },
//                 icon: const Icon(Icons.search),
//                 label: const Text("扫一扫"))
//           ]),
//         ));
//   }
// }
