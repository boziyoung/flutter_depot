// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../common/storage.dart';
import '../../network/api.dart';

// import '../../network/api.dart';

class LoginController extends GetxController {
  var isObscure = true.obs;

  @override
  void onInit() {
    _judgeLoginState();
    super.onInit();
  }

  void _judgeLoginState() async {
    String? T = await StorageOperation.get("key");
    if (T != null) {
      Get.offNamed('/goodslist');
    }
  }

  void showPassw() {
    isObscure.value = !isObscure.value;
  }

  void login(dynamic data) async {
    var resp = await Api.getToken(data);
    if (resp.runtimeType.toString() == "Null") {
      Fluttertoast.showToast(
        msg: "密码或者账号输入错误",
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
    } else {
      print("access ${resp["access"]}");
      // 登陆成功保存 token
      StorageOperation.add("key", resp["access"]);
      print("refresh ${resp["refresh"]}");
      StorageOperation.add("refresh", resp["refresh"]);
      Get.toNamed('/goodslist');
    }
  }
}
