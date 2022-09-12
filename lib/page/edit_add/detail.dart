import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detailController.dart';

class GoodsDetailPage extends StatelessWidget {
  GoodsDetailPage({Key? key}) : super(key: key);
  DetailController dc = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mrs.Wang Grocery Store"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            // 使用 输入框进行记录和输入相关数据
            // code 输入框 商品的唯一确定码
            Obx((() {
              return TextField(
                // enable textFiled 的禁用状态
                enabled: dc.editable as bool,
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
                controller: dc.codeController,
              );
            })),

            Obx((() {
              return TextField(
                enabled: dc.editable as bool,
                autofocus: true,
                // 设定键盘输入类型
                keyboardType: TextInputType.text,
                // 验证输入格式
                // inputFormatters: [ ],
                // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
                decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "商品名字，最好为唯一值",
                    prefixIcon: Icon(Icons.info)),
                // 获取输入数据内容 通过 controller 获取
                controller: dc.nameController,
              );
            })),

            Obx((() {
              return TextField(
                enabled: dc.editable as bool,
                autofocus: true,
                // 设定键盘输入类型
                keyboardType: TextInputType.number,
                // 验证输入格式
                // inputFormatters: [ ],
                // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
                decoration: const InputDecoration(
                    labelText: "Count",
                    hintText: "商品数量， 计价单位为 市斤、个、箱",
                    prefixIcon: Icon(Icons.info)),
                // 获取输入数据内容 通过 controller 获取
                controller: dc.countController,
              );
            })),

            Obx((() {
              return TextField(
                enabled: dc.editable as bool,
                autofocus: true,
                // 设定键盘输入类型
                keyboardType: TextInputType.number,
                // 验证输入格式
                // inputFormatters: [ ],
                // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
                decoration: const InputDecoration(
                    labelText: "Prices",
                    hintText: "商品销售价格，单位为元",
                    prefixIcon: Icon(Icons.info)),
                // 获取输入数据内容 通过 controller 获取
                controller: dc.pricesController,
              );
            }))
          ],
        )),
      ),
    );
  }
}
