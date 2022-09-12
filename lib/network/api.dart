// ignore: slash_for_doc_comments
/**
 * 将所有的 api 接口封装在一起
*/
import 'dart:io';

import 'package:depot/network/send_request.dart';

class Api {
  // 获取token
  static getToken(dynamic data) {
    return Request.post("/api/token", data: data);
  }

  // 刷新Token
  static refreshToekn(dynamic data) {
    return Request.post('/api/token/refresh/', data: data);
  }

  // 验证Token
  static verifyToken(dynamic data) {
    return Request.post('/api/token/verify/', data: data);
  }

  // 获取所有depot信息
  static getAlldepot() {
    return Request.get('/depot/');
  }

  // 获取单个depot信息
  static getSingeldepot(String pk) {
    return Request.get('/depot/$pk');
  }

  // 修改单个depot信息
  static putSingeldepot(String pk, dynamic data, String T) {
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $T',
      HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
    };
    return Request.put('/depot/$pk', data: data, headrers: headers);
  }

  // 删除单个depot信息
  static delteSingeldepot(String pk, dynamic data, String T) {
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $T',
      HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
    };
    return Request.delete('/depot/$pk', data: data, headrers: headers);
  }

  // 添加depot 信息
  static addDepot(dynamic data, String T) {
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $T',
      HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
    };
    return Request.put('/depot/', data: data, headrers: headers);
  }

  // 通过 code 获取信息
  static getCodeInfo(String code) {
    return Request.get('/depot/$code/get_code/');
  }
}
