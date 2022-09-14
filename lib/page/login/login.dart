/*
登录界面， 使用其它图片
自定义 图片 需要在 flutter_depot\pubspec.yaml 中添加
assets:
    img_path
 */
// import 'dart:convert';

// import 'package:depot/common/storage.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../../common/rootbar.dart';
import 'loginController.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  LoginController lc = Get.put(LoginController());
  // 一个 form 可以通过指定key 来统一整个 Form 的输入框， 参照Form 的构造函数
  // 一般我们通过创建一个 GolbalKey<FormState> 关联
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            // 圆形图片 切角
            ClipOval(
              child: Image.asset(
                "imges/_avator.jpg",
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Form(
                  key: _loginKey,
                  child: Column(children: [
                    // 用户名
                    TextFormField(
                      decoration: const InputDecoration(labelText: "请输入用户名"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "用户名不可为空！";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                      onFieldSubmitted: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // 密码框
                    Obx(() {
                      return TextFormField(
                        decoration: InputDecoration(
                            labelText: "请输入密码",
                            suffixIcon: IconButton(
                                // iocn button  样式修改
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                padding: const EdgeInsets.all(2.0),
                                onPressed: () {
                                  lc.showPassw();
                                },
                                icon: Icon(lc.isObscure.value
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                        obscureText: lc.isObscure.value,
                        validator: (value) {
                          if (value!.length < 6 || value.isEmpty) {
                            return "密码长度不够6位！";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    )
                  ]),
                )),
            ElevatedButton(
              style: ButtonStyle(
                // 使用 minimumSize 控制ElevatedButton 的大小
                minimumSize: MaterialStateProperty.all(const Size(50, 20)),
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.black;
                }),
              ),
              onPressed: () {
                // 通过 _loginKey.currenstate 转换 为Formaste类型 后，
                // 调用 validata()方法校验用户名 密码是否合法、
                // 校验通过后再提交数据
                if ((_loginKey.currentState as FormState).validate()) {
                  _loginKey.currentState?.save();
                  // 调用登录接口
                  Map data = {"username": username, "password": password};
                  // Map p = {'username': 'bzy', 'password': 'QQqq11!!'};
                  // print(data);
                  lc.login(data);
                }
              },
              child: const Text(
                "登录",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   // 全局key，后续 表单统一验证处理
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _username = TextEditingController();
//   final TextEditingController _pw = TextEditingController();

//   // 登录接口
//   Future<String?> _login(String name, String pw) async {
//     try {
//       Dio _dio = Dio();
//       String url = "http://139.155.16.210:8000/auth/login/";
//       FormData formData = FormData.fromMap({"username": name, "password": pw});
//       // 发起请求
//       Response _res = await _dio.post(url, data: formData);

//       // 获取返回值 对其 持久化保存
//       print(json.decode(_res.toString())["key"]);
//       StorageOperation.add("test", json.decode(_res.toString())["key"]);

//       return _res.statusCode.toString();
//     } // Exception 任一 错误
//     on Exception catch (e) {
//       return "404";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false, // 键盘弹起引起的挤压问题

//         // 底部导航栏
//         bottomNavigationBar: BottonBar(context),
//         body: Center(
//           child: SingleChildScrollView(
//             /*SingleChildScrollView  与 expaned () 不可兼容 */

//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 //
//                 // 圆形图片 切角
//                 ClipOval(
//                   child: Image.asset(
//                     "imges/_avator.jpg",
//                     width: 200,
//                     height: 200,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 100,
//                 ),
//                 // const SizedBox(height: 3,),
//                 // 使用 form TextFormField 创建登录框
//                 /*Form 组件，它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。 */
//                 Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: TextFormField(
//                             controller: _username,
//                             autofocus: true,
//                             decoration: const InputDecoration(
//                                 labelText: "请输入用户名",
//                                 icon: Icon(CupertinoIcons.person)),
//                             // validator 进行 数据输入校验
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "邮箱不可为空";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: TextFormField(
//                             controller: _pw,
//                             autofocus: true,
//                             // 隐藏密码 文本
//                             obscureText: true,

//                             decoration: const InputDecoration(
//                                 labelText: "请输入密码",
//                                 icon: Icon(CupertinoIcons.lock)),
//                             // validator 进行 数据输入校验
//                             validator: (value) {
//                               if (value!.length < 6 || value.isEmpty) {
//                                 return "密码长度不够6位！";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     )),
//                 const SizedBox(
//                   height: 50,
//                 ),

//                 ElevatedButton(
//                     // style:,
//                     onPressed: () async {
//                       // 登录
//                       if ((_formKey.currentState as FormState).validate()) {
//                         //  验证通过提交数据(登录)
//                         // print(_username.text);
//                         // print(_pw.text);
//                         var statueCode = await _login(_username.text, _pw.text);
//                         if (statueCode == "200") {
//                           // print("object");
//                           // 跳转新页面 - 用户详情页面
//                           Navigator.pushNamed(context, "/userinfo");
//                         } else {
//                           // print("eerr");
//                           // 弹出错误toast
//                           Fluttertoast.showToast(
//                             msg: "用户名或者密码错误",
//                             // 显示位置
//                             gravity: ToastGravity.TOP,
//                             toastLength: Toast.LENGTH_LONG,
//                             //
//                             backgroundColor: Colors.red,
//                             textColor: Colors.white,
//                             fontSize: 20.0,
//                           );
//                         }
//                       }
//                     },
//                     child: const Text(
//                       "登录",
//                       style: TextStyle(fontSize: 18),
//                     )),
//                 const SizedBox(
//                   height: 80,
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
