import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Request {
  // 配置 Dio 实例
  static final BaseOptions _options = BaseOptions(
    baseUrl: 'http://1.14.121.231:8000',
    // baseUrl: "http://127.0.0.1:8000",
    connectTimeout: 5000,
    receiveTimeout: 5000,
  );

  // 创建 Dio 实例
  static final Dio _dio = Dio(_options);

  static dynamic _request(String path,
      {String? method, Map? data, Map<String, dynamic>? headers}) async {
    // restful 请求处理
    // print("发生的path: $path");

    LogUtil.v("发生的data: $data");
    try {
      Response response = await _dio.request(path,
          data: data, options: Options(method: method, headers: headers));
      // print("object${response.statusCode}");
      // 通过对response 的status code 的结果进行判断
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          LogUtil.v(response.data);
          // print("request: ${response.data.toString()}");
          // 返回response的数据
          return response.data;
        } catch (e) {
          LogUtil.v(e);
          LogUtil.v("错误data：${response.data}");
          // 解析错误：
          // 新增 toast 提醒报错
          Fluttertoast.showToast(
            msg: "解析错误",
            // backgroundColor: style.background,
            textColor: Colors.white,
            gravity: ToastGravity.TOP,
            webPosition: "center",
          );
        }
      } else if (method == "delete" && response.statusCode == 204) {
        return {"state": "ok"};
      } else {
        if (response.statusCode != null) {
          LogUtil.v(response.statusCode);
          _handleHttpError(response.statusCode);
        }
      }
    } on DioError catch (e) {
      LogUtil.v(_dioError(e), tag: '请求异常');
      // 新增 toast 提醒报错
      Fluttertoast.showToast(
        msg: _dioError(e),
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
    } catch (e) {
      LogUtil.v(e);
// 新增 toast 提醒报错
      Fluttertoast.showToast(
        msg: "未知异常",
        // backgroundColor: style.background,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        webPosition: "center",
      );
    }
  }

  // 处理 Dio 异常
  static String _dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.receiveTimeout:
        return "服务器异常，请稍后重试！";
      case DioErrorType.sendTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.response:
        return "服务器异常，请稍后重试！";
      case DioErrorType.cancel:
        return "请求已被取消，请重新请求";
      case DioErrorType.other:
        return "网络异常，请稍后重试！";
      default:
        return "Dio异常";
    }
  }

  // 处理 Http 错误码
  static void _handleHttpError(int? errorCode) {
    String message;
    switch (errorCode) {
      case 400:
        message = '请求语法错误';
        break;
      case 401:
        message = '未授权，请登录';
        break;
      case 403:
        message = '拒绝访问';
        break;
      case 404:
        message = '请求出错';
        break;
      case 408:
        message = '请求超时';
        break;
      case 500:
        message = '服务器异常';
        break;
      case 501:
        message = '服务未实现';
        break;
      case 502:
        message = '网关错误';
        break;
      case 503:
        message = '服务不可用';
        break;
      case 504:
        message = '网关超时';
        break;
      case 505:
        message = 'HTTP版本不受支持';
        break;
      default:
        message = '请求失败，错误码：$errorCode';
    }
    // 新增 toast 提醒报错
    Fluttertoast.showToast(
      msg: message,
      // backgroundColor: style.background,
      textColor: Colors.white,
      gravity: ToastGravity.TOP,
      webPosition: "center",
    );
  }

  // 这里只写了 get 和 post，其他的别名大家自己手动加上去就行
  static dynamic get(
    String path, {
    String? method,
    Map? data,
    Map<String, dynamic>? headrers,
  }) {
    // print("object $path");
    return _request(path, method: "get", headers: headrers);
  }

  static dynamic post(
    String path, {
    String? method,
    Map? data,
    Map<String, dynamic>? headrers,
  }) {
    return _request(path, method: "post", data: data, headers: headrers);
  }

  static dynamic delete(
    String path, {
    String? method,
    Map? data,
    Map<String, dynamic>? headrers,
  }) {
    return _request(path, method: "delete", data: data, headers: headrers);
  }

  static dynamic put(
    String path, {
    String? method,
    Map? data,
    Map<String, dynamic>? headrers,
  }) {
    return _request(path, method: "put", data: data, headers: headrers);
  }
}
