import 'dart:io';

import 'package:depot/common/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/rootbar.dart';

// ignore: must_be_immutable
class AddGoods extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final Map code;
  const AddGoods({Key? key, required this.code}) : super(key: key);

  @override
  _AddGoodsState createState() => _AddGoodsState();
}

class _AddGoodsState extends State<AddGoods> {
  // 定义 code 输入controller
  late TextEditingController _codeController = TextEditingController(text: "");
  late TextEditingController _countController = TextEditingController(text: "");
  late TextEditingController _nameController = TextEditingController(text: "");
  late TextEditingController _pricesController =
      TextEditingController(text: "");

  // 初始化 可输入状态
  bool editedstate = false;

  // 传入的参数值，不能直接在 controller 中使用
  @override
  // ignore: must_call_super
  void initState() {
    // print(widget.code["code"].toString());
    // 通过进行判断 id 是否为空进行数据初始化
    if (widget.code["code"]["id"] == null) {
      editedstate = true;
      setState(() {
        _codeController =
            TextEditingController(text: widget.code["code"]["code"].toString());
        _pricesController = TextEditingController(text: "");
        _countController = TextEditingController(text: "");
        _nameController = TextEditingController(text: "");
      });
    } else {
      setState(() {
        _codeController =
            TextEditingController(text: widget.code["code"]["code"].toString());
        _countController = TextEditingController(
            text: widget.code["code"]["count"].toString());
        _pricesController = TextEditingController(
            text: widget.code["code"]["prices"].toString());
        _nameController =
            TextEditingController(text: widget.code["code"]["name"].toString());
      });
    }
  }

  // 创建添加商品 接口
  Future<dynamic> _addgoods() async {
    var body = {
      "code": _codeController.text,
      "name": _nameController.text,
      "count": _countController.text,
      "prices": _pricesController.text,
    };
    String url = "http://139.155.16.210:8000/depot/";
    Dio dio = Dio();
    // 获取 验证信息
    var t = await StorageOperation.get("test");
    Options options = Options(headers: {
      HttpHeaders.authorizationHeader: 'Token $t',
      HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
    });
    try {
      Response _rep = await dio.post(url, options: options, data: body);
      if (_rep.statusCode == 201) {
        // 请求成功
        Fluttertoast.showToast(
          msg: "添加成功",
          // 显示位置
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG,
          //
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "输入错误",
          // 显示位置
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG,
          //
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      }
    } on Exception catch (e) {}
  }

// 创建修改商品 接口
  Future<dynamic> _editgoods(String Id) async {
    var body = {
      "code": _codeController.text,
      "name": _nameController.text,
      "count": _countController.text,
      "prices": _pricesController.text,
    };
    String url = "http://139.155.16.210:8000/depot/$Id/";
    Dio dio = Dio();
    // 获取 验证信息
    var t = await StorageOperation.get("test");
    Options options = Options(headers: {
      HttpHeaders.authorizationHeader: 'Token $t',
      HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
    });
    try {
      Response _rep = await dio.put(url, options: options, data: body);
      if (_rep.statusCode == 200) {
        // 请求成功
        Fluttertoast.showToast(
          msg: "添加成功",
          // 显示位置
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG,
          //
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "输入错误",
          // 显示位置
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG,
          //
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      }
    } on Exception catch (e) {}
  }

  void _deleteGoods(String id) async {
    String url = "http://139.155.16.210:8000/depot/$id/";
    Dio dio = Dio();
    // 获取 验证信息
    var t = await StorageOperation.get("test");
    Options options = Options(headers: {
      HttpHeaders.authorizationHeader: 'Token $t',
      HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
    });
    try {
      Response _resp = await dio.delete(url, options: options);
      if (_resp.statusCode.toString() == "204") {
        Fluttertoast.showToast(
          msg: "删除成功",
          // 显示位置
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG,
          //
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "删除失败",
        // 显示位置
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
        //
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("W_depot"),
      ),
      // 添加根 导航
      bottomNavigationBar: BottonBar(context),
      body: Center(
        child: Column(
          children: [
            // 使用 输入框进行记录和输入相关数据
            // code 输入框 商品的唯一确定码
            TextField(
              enabled: editedstate,
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
              controller: _codeController,
            ),

            TextField(
              enabled: editedstate,
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
              controller: _nameController,
            ),

            TextField(
              enabled: editedstate,
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
              controller: _countController,
            ),

            TextField(
              enabled: editedstate,
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
              controller: _pricesController,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      // 清除 除 code 的所有输入框
                      _nameController.clear();
                      _countController.clear();
                      _pricesController.clear();
                    },
                    child: const Text("清除")),
                TextButton(
                    onPressed: () {
                      // 设置输入框 可输入状态
                      setState(() {
                        editedstate = true;
                      });
                    },
                    child: const Text("编辑")),
                TextButton(
                  onPressed: () {
                    if (widget.code["code"]["id"] != null) {
                      _editgoods(widget.code["code"]["id"].toString());
                    } else {
                      _addgoods();
                    }
                  },
                  child: const Text("提交"),
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                ),
                TextButton(
                    onPressed: () {
                      if (widget.code["code"]["id"] != null) {
                        _deleteGoods(widget.code["code"]["id"].toString());
                      } else {
                        Fluttertoast.showToast(
                          msg: "id错误，不可删除",
                          // 显示位置
                          gravity: ToastGravity.TOP,
                          toastLength: Toast.LENGTH_LONG,
                          //
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 20.0,
                        );
                      }
                    },
                    child: const Text("删除")),
              ],
              // 子组件 在 row中的对齐方式
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ],
          // 子组件 在 cloumn中的对齐方式
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}
