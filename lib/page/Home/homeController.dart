import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:get/get.dart';

// import '../../network/api.dart';

class HomeController extends GetxController {
  var goodsInfo = {}.obs;

  // 使用barcode_scan2进行 扫码获取二维码 or 条纹码信息
  Future<String> qs() async {
    // 设置扫码 options的信息
    var options = const ScanOptions(strings: {
      'cancel': "取消",
      'flash_on': "闪光灯",
      'flash_off': "关闭",
    }, android: AndroidOptions(useAutoFocus: false));
    var result = await BarcodeScanner.scan(options: options);
    // print(result.type);
    // print(result.rawContent);
    // print(result.format);
    // print(result.formatNote);
    return result.rawContent;
  }

  // void getGoodsPrices(String code) async {
  //   var response = await Api.getCodeInfo(code);
  //   print("${response.runtimeType.toString()}\n test");
  //   if (response.runtimeType.toString() == "Null") {
  //     print("type is right");
  //   } else if (response.runtimeType.toString() ==
  //       "_InternalLinkedHashMap<String, dynamic>") {
  //     print("content is right ");
  //   }

  //   // goodsInfo = response;
  // }
}
