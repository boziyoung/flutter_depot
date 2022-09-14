import 'package:depot/common/storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../network/api.dart';

class DetailController extends GetxController {
  // 定义 code 输入controller
  late var codeController = TextEditingController(text: "").obs;
  late var countController = TextEditingController(text: "").obs;
  late var nameController = TextEditingController(text: "").obs;
  late var pricesController = TextEditingController(text: "").obs;
  var editable = false.obs;
  var goodsInfo = {}.obs;

  @override
  void onInit() {
    var code = Get.parameters["code"];
    getGoodsPrices(code!);
    super.onInit();
  }

  void delete(String pk) async {
    var T = await judgeToken();
    var resp = await Api.delteSingeldepot(pk, T.toString());
    if (resp["state"] == "ok") {
      Fluttertoast.showToast(
        msg: "商品删除成功",
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
      Get.offAllNamed("/");
    } else {
      Fluttertoast.showToast(
        msg: "商品删除失败",
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
    }
  }

  void add(dynamic data) async {
    var T = await judgeToken();
    print(T.toString());
    var resp = await Api.addDepot(data, T.toString());
    print(resp);
    if (resp["code"].toString() == data["code"].toString()) {
      Fluttertoast.showToast(
        msg: "商品添加成功",
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
      Get.offNamed("/${resp["code"]}/detail");
    } else {
      Fluttertoast.showToast(
        msg: "商品添加错误",
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
    }
  }

  void edit(String pk, dynamic data) async {
    var T = await judgeToken();
    print(T.toString());
    var resp = await Api.putSingeldepot(pk, data, T.toString());
    // print("edit: ${resp.runtimeType}");
    if (resp["id"].toString() == pk) {
      Fluttertoast.showToast(
        msg: "商品信息修改成功",
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
      Get.offNamed("/${resp["code"].toString()}}/detail");
    } else {
      Fluttertoast.showToast(
        msg: "商品信息修改错误",
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
    }
  }

  Future judgeToken() async {
    String? T = await StorageOperation.get("key");
    if (T != null) {
      print(T);
      return T;
    } else {
      Get.offNamed("/login");
    }
  }

  Future getGoodsPrices(String code) async {
    List response = await Api.getCodeInfo(code);
    print(response.runtimeType);
    if (response.isEmpty) {
      print("Empty is right");
      codeController.value = TextEditingController(text: code);
      editable.value = true;
    } else if (response.isNotEmpty) {
      print("content is right ");
      goodsInfo.value = response[0];
      codeController.value = TextEditingController(text: code);
      pricesController.value =
          TextEditingController(text: goodsInfo["prices"].toString());
      countController.value =
          TextEditingController(text: goodsInfo["count"].toString());
      nameController.value =
          TextEditingController(text: goodsInfo["name"].toString());
    }
    // return response;
  }
}
