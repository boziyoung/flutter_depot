/*
对相关数据进行持久化保存
shared_preferences 进行一个 二次封装 方便其它地方进行调用
*/

import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static String url = "";
}

class StorageOperation {
  // 此处使用 _ 做为函数名， 默认为 私有方法，其他位置不可调用
  // 添加
  static add(String key, String value) async {
    final pers = await SharedPreferences.getInstance();
    await pers.setString(key, value);
  }

  // 获取 持久化的数据
  static Future<String?> get(String key) async {
    final pers = await SharedPreferences.getInstance();
    String? value = pers.getString(key);
    return value;
  }

  // 删除相关数据
  static move(String key) async {
    final pers = await SharedPreferences.getInstance();
    pers.remove(key);
  }
}
