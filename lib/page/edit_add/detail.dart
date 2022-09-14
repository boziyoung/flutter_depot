import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/rootbar.dart';
import 'detailController.dart';

class GoodsDetailPage extends StatelessWidget {
  GoodsDetailPage({Key? key}) : super(key: key);
  DetailController dc = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(context),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            // 使用 输入框进行记录和输入相关数据
            // code 输入框 商品的唯一确定码
            Obx((() {
              return TextField(
                // enable textFiled 的禁用状态
                enabled: dc.editable.value,
                autofocus: true,
                // 设定键盘输入类型
                keyboardType: TextInputType.number,
                // 验证输入格式
                // inputFormatters: [ ],
                // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
                decoration: const InputDecoration(
                    labelText: "Code",
                    hintText: "唯一数字标识码",
                    prefixIcon: Icon(Icons.info)),
                // 获取输入数据内容 通过 controller 获取
                controller: dc.codeController.value,
              );
            })),

            Obx((() {
              return TextField(
                enabled: dc.editable.value,
                autofocus: true,
                // 设定键盘输入类型
                keyboardType: TextInputType.text,
                // 验证输入格式
                // inputFormatters: [ ],
                // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
                decoration: const InputDecoration(
                    labelText: "名称",
                    hintText: "商品名字，最好为唯一值",
                    prefixIcon: Icon(Icons.info)),
                // 获取输入数据内容 通过 controller 获取
                controller: dc.nameController.value,
              );
            })),

            Obx((() {
              return TextField(
                enabled: dc.editable.value,
                autofocus: true,
                // 设定键盘输入类型
                keyboardType: TextInputType.number,
                // 验证输入格式
                // inputFormatters: [ ],
                // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
                decoration: const InputDecoration(
                    labelText: "库存",
                    hintText: "商品数量， 计价单位为 市斤、个、箱",
                    prefixIcon: Icon(Icons.info)),
                // 获取输入数据内容 通过 controller 获取
                controller: dc.countController.value,
              );
            })),

            Obx((() {
              return TextField(
                enabled: dc.editable.value,
                autofocus: true,
                // 设定键盘输入类型
                keyboardType: TextInputType.number,
                // 验证输入格式
                // inputFormatters: [ ],
                // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
                decoration: const InputDecoration(
                    labelText: "单件",
                    hintText: "商品销售价格，单位为元",
                    prefixIcon: Icon(Icons.info)),
                // 获取输入数据内容 通过 controller 获取
                controller: dc.pricesController.value,
              );
            })),

            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      if (dc.editable.value) {
                      } else {
                        dc.editable.value = true;
                      }
                    },
                    child: const Text(
                      "编辑",
                      style: TextStyle(color: Colors.white),
                    ), // 按钮样式
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.green,
                    )),
                TextButton(
                    onPressed: () {
                      Map data = {
                        // "id": dc.goodsInfo["id"],
                        "name": dc.nameController.value.text,
                        "count": dc.countController.value.text,
                        "prices": dc.pricesController.value.text,
                        "code": dc.codeController.value.text
                      };
                      if (dc.goodsInfo.isNotEmpty) {
                        dc.edit(dc.goodsInfo["id"].toString(), data);
                      } else {
                        dc.add(data);
                      }
                    },
                    child: const Text(
                      "提交",
                      style: TextStyle(color: Colors.white),
                    ), // 按钮样式
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.blue,
                    )),
                TextButton(
                    onPressed: () {
                      // print(object)
                      // var id = dc.goodsInfo["id"];
                      // print(id);
                      if (dc.goodsInfo.isEmpty) {
                      } else {
                        var id = dc.goodsInfo["id"];
                        // print(id);
                        Get.defaultDialog(
                          title: "您确定删除该商品吗？",
                          titleStyle:
                              const TextStyle(color: Colors.amberAccent),
                          content: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text("删除后，与该商品相关信息都不会被保留，请谨慎操作"),
                          ),
                          onConfirm: () {
                            print("confirm");
                            // 删除 该商品后弹框 消失 回到 商品列表页面
                            dc.delete(id.toString());
                          },
                          textCancel: "取消",
                          textConfirm: "确认",
                          confirmTextColor: Colors.white,
                          buttonColor: Colors.black,
                          // 可自定义 cancel 和 confirm 按钮
                          // 自定义 cancel  confirm  上面的各个按钮设置属性可以重新在 cancel 的 button 中显示
                          backgroundColor: Colors.grey.withOpacity(.5),
                          barrierDismissible: false, // 点击其他地方，alert 不会消失
                          radius: 10.0, // 圆角
                        );
                      }
                    },
                    child: const Text(
                      "删除",
                      style: TextStyle(color: Colors.white),
                    ), // 按钮样式
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.red,
                    )),
              ],
            )
          ],
        )),
      ),
    );
  }
}
