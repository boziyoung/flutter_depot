import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/api.dart';

class DetailController extends GetxController {
  // 定义 code 输入controller
  late TextEditingController codeController = TextEditingController(text: "");
  late TextEditingController countController = TextEditingController(text: "");
  late TextEditingController nameController = TextEditingController(text: "");
  late TextEditingController pricesController = TextEditingController(text: "");
  var editable = false.obs;
  var goodsInfo = {}.obs;

  void _judge_code_exist() {}

  Future getGoodsPrices(String code) async {
    var response = await Api.getCodeInfo(code);
  }
}
