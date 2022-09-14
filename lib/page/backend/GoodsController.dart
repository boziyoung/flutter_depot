import 'package:get/get.dart';

import '../../common/storage.dart';
import '../../network/api.dart';

class GoodsController extends GetxController {
  late var goodsList;

  LoadingStatus _loadingStatus = LoadingStatus.loading;
  // ?
  /// get 和 set 方法是一对用来读写对象属性的特殊方法，
  /// 其实，实例对象的每一个属性都有一个隐式的 get 方法，
  /// 而且如果为非 final 属性的话还会有一个 set 方法。
  /// 置私有字段的 get 方法 , 让外界可以访问类对象的私有成员 ;
  get loadingStatus => _loadingStatus;

  /// set 方法 : 置私有字段的 set 方法 , 让外界可以设置类对象的私有成员 ;

  void onInit() {
    getGoodsList();
    super.onInit();
  }

  void getGoodsList() async {
    // goodsList.re([]);
    var resp = await Api.getAlldepot();
    print("list: ${resp.runtimeType}");
    print(resp);
    if (resp.runtimeType.toString() == "List<dynamic>") {
      print(resp);
      goodsList = resp;
      _loadingStatus = LoadingStatus.success;
      update();
    } else {
      _loadingStatus = LoadingStatus.failed;
      print("faild");
      update();
    }
  }
}
