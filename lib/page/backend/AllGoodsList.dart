/*
详细显示 所有商品的信息
 */

import 'package:depot/common/rootbar.dart';
import 'package:depot/common/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../Home/homeController.dart';
import 'GoodsController.dart';

class GoodsListPage extends StatelessWidget {
  GoodsListPage({Key? key}) : super(key: key);
  // 输入框编辑器控制器
  TextEditingController vc = TextEditingController(text: "");
  HomeController hc = Get.put(HomeController());
  GoodsController gc = Get.put(GoodsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(context),
      body: GetBuilder<GoodsController>(
        builder: ((controller) {
          if (controller.loadingStatus == LoadingStatus.success) {
            return RefreshIndicator(
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            "商品名字： ${controller.goodsList[index]["name"]}"),
                        subtitle: Text(
                            "库存数量： ${controller.goodsList[index]["count"]}"),
                        selected: true,
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Get.offAllNamed(
                              '/${controller.goodsList[index]["code"]}/detail');
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      // return const Divider(height: 2, indent: 0, color: Colors.grey);
                      return const SizedBox(
                          width: 80,
                          child: Divider(
                              height: 2, color: Colors.grey, thickness: 2));
                    },
                    itemCount: controller.goodsList.length),
                onRefresh: () async {
                  gc.goodsList = [];
                  gc.getGoodsList();
                });
          } else if (controller.loadingStatus == LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),

      bottomNavigationBar: BottonBar(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // 设置float button 的显示位置
      floatingActionButton: IconButton(
          color: Colors.blue, // 按钮icon的颜色
          // splashColor: Colors.blue,  // 一闪而过的 背景颜色
          // highlightColor: Colors.blue,  // 点击时的背景颜色
          onPressed: (() {
            // Get.to(GoodsDetailPage());
            Get.bottomSheet(
              Container(
                height: 100,
                color: Colors.white,
                child: ListView(
                  children: [
                    TextButton.icon(
                        onPressed: () async {
                          var code = await hc.qs();
                          print("code: $code");
                          Get.offAllNamed("/$code/detail");
                        },
                        icon: const Icon(Icons.search),
                        label: const Text("扫码添加")),
                    TextButton.icon(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "输入您需要添加商品的Code码",
                            titleStyle: const TextStyle(color: Colors.blue),
                            content: TextField(
                              // 设定键盘输入类型
                              keyboardType: TextInputType.number,
                              // 验证输入格式
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]")),
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
                        icon: const Icon(Icons.book),
                        label: const Text("文本添加"))
                  ],
                ),
              ),
              enableDrag: false, // 设置拖拽属性
              isDismissible: true, // 点击其他地方，不会消失
            );
          }),
          icon: const Icon(Icons.add)),
    );
  }
}

// class DetailUserInfo extends StatefulWidget {
//   const DetailUserInfo({Key? key}) : super(key: key);

//   @override
//   _DetailUserInfoState createState() => _DetailUserInfoState();
// }

// class _DetailUserInfoState extends State<DetailUserInfo> {
//   final goodsList = [];

//   // 初始化方法
//   @override
//   void initState() {
//     super.initState();
//     _get_all_goods();
//   }

//   // 获取 货物的所有数据
//   // ignore: non_constant_identifier_names
//   void _get_all_goods() async {
//     String url = "http://139.155.16.210:8000/depot/";
//     Dio dio = Dio();
//     try {
//       Response _rep = await dio.get(url);
//       if (_rep.statusCode.toString() == "200") {
//         print(_rep.toString());
//         setState(() {
//           goodsList.addAll(_rep.data);
//           print(goodsList.length.toString());
//           print(goodsList[0]["name"]);
//         });
//       }
//     } on Exception catch (e) {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("WY_depot"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             // const SizedBox(
//             //   height: 20,
//             // ),
//             // 避免 ListView 在 column 中大小尺寸出错， 使用 expanded 来控制显示大小
//             Expanded(
//                 /*SingleChildScrollView  与 expaned () 不可兼容 */
//                 child: ListView.builder(
//                     //item 高度会适配 item填充的内容的高度
//                     shrinkWrap: true, // use
//                     itemExtent: 60.0,
//                     itemCount: goodsList.length,
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         leading: const Icon(Icons.dehaze),
//                         subtitle:
//                             Text("价格：" + goodsList[index]["prices"].toString()),
//                         title: Text(goodsList[index]["name"]),
//                         // 跳转到 商品详情页面
//                         onTap: () {
//                           Navigator.pushNamed(context, '/add_goods',
//                               arguments: {"code": goodsList[index]});
//                         },
//                         trailing: const Icon(Icons.arrow_forward_ios),
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20.0),
//                         // 图片是否是 列表中的一部分
//                         enabled: true,
//                       );
//                     })),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
