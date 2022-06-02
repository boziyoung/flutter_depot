/*
登录界面， 使用其它图片
自定义 图片 需要在 flutter_depot\pubspec.yaml 中添加
assets:
    img_path
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/rootbar.dart';


class Login extends StatefulWidget {

const Login({Key? key}) : super(key: key);
 
@override
_LoginState createState() => _LoginState();
}
 
class _LoginState extends State<Login> {
  // 全局key，后续 表单统一验证处理
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController(); 
  final TextEditingController _pw = TextEditingController ();

@override
Widget build(BuildContext context) {
return Scaffold(
  resizeToAvoidBottomInset: false, // 键盘弹起引起的挤压问题

  // 底部导航栏
  bottomNavigationBar: BottonBar(context),
  body:  Center(
    child: SingleChildScrollView(
      /*SingleChildScrollView  与 expaned () 不可兼容 */
    
      child:Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        // 
        // 圆形图片 切角
        ClipOval(child: Image.asset("imges/_avator.jpg",
        width: 200, height: 200,),
        ),
        const SizedBox(height: 100,),
        // const SizedBox(height: 3,),
        // 使用 form TextFormField 创建登录框
        /*Form 组件，它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。 */
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:  TextFormField(
             controller: _username,
              autofocus: true,
              decoration: const InputDecoration(labelText: "请输入用户名",  icon: Icon(CupertinoIcons.person)),
              // validator 进行 数据输入校验
              validator: (value){
                if (value!.isEmpty){
                  return "邮箱不可为空";
                }
                return null;
              },
           ),
              ),
              const SizedBox(height: 10,),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:  
           TextFormField(
             controller: _pw,
              autofocus: true,
              // 隐藏密码 文本
              obscureText : true,

              decoration: const InputDecoration(labelText: "请输入密码",  icon: Icon(CupertinoIcons.lock)),
              // validator 进行 数据输入校验
              validator: (value) {
                if (value!.length < 6 || value.isEmpty) {
                  return "密码长度不够6位！";
                }
                return null;
                },
           ),),
        ],)),
        const SizedBox(height: 50,),

          ElevatedButton(
            // style:,
            onPressed: (){
            // 登录
            if ((_formKey.currentState as FormState).validate()){
              //  验证通过提交数据(登录)
              print(_username.text);
              print(_pw.text);
            }

          }, child: const Text("登录", style: TextStyle(fontSize: 18),)),
          const SizedBox(height:80,),


      ],
    ),
  ),
));
}
}