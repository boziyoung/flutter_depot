import 'package:flutter/material.dart';
import '../common/rootbar.dart';


// ignore: must_be_immutable
class AddGoods extends StatefulWidget {
 final code;
 const AddGoods( {Key? key, this.code}):super(key: key);
 
@override
_AddGoodsState createState() => _AddGoodsState();
}
 
class _AddGoodsState extends State<AddGoods> {
  // 定义 code 输入controller
  late TextEditingController _codeController = TextEditingController(text: "");
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pricesController = TextEditingController();

  // 传入的参数值，不能直接在 controller 中使用
   @override
   // ignore: must_call_super
   void initState(){
     setState(() {
       _codeController = TextEditingController(text: widget.code["code"]);
     });
   }

  // 创建添加商品 接口
  Future<dynamic>_addgoods() async{
    var body = {
      "code" : _codeController.text,
      "name" : _nameController.text,
      "count" : _countController.text,
      "prices" : _pricesController.text,
    };
    print(body);
  } 

@override
Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(title: const Text("W_depot"),),
  // 添加根 导航
  bottomNavigationBar: BottonBar(context),
  body: Center(
    child: Column(
      children: [
        // 使用 输入框进行记录和输入相关数据
        // code 输入框 商品的唯一确定码
        TextField(
          autofocus: true,
          // 设定键盘输入类型
          keyboardType: TextInputType.number,
          // 验证输入格式
          // inputFormatters: [ ],
          // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
          decoration: const InputDecoration(
            labelText: "Code",
            hintText: "唯一数字标识码" ,
            prefixIcon: Icon(Icons.info)
          ),
          // 获取输入数据内容 通过 controller 获取
          controller: _codeController,
        ),

        TextField(
          autofocus: true,
          // 设定键盘输入类型
          keyboardType: TextInputType.text,
          // 验证输入格式
          // inputFormatters: [ ],
          // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
          decoration: const InputDecoration(
            labelText: "Name",
            hintText: "商品名字，最好为唯一值" ,
            prefixIcon: Icon(Icons.info)
          ),
          // 获取输入数据内容 通过 controller 获取
          controller: _nameController,
        ),

        TextField(
          autofocus: true,
          // 设定键盘输入类型
          keyboardType: TextInputType.number,
          // 验证输入格式
          // inputFormatters: [ ],
          // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
          decoration: const InputDecoration(
            labelText: "Count",
            hintText: "商品数量， 计价单位为 市斤、个、箱" ,
            prefixIcon: Icon(Icons.info)
          ),
          // 获取输入数据内容 通过 controller 获取
          controller: _countController,
        ),

        TextField(
          autofocus: true,
          // 设定键盘输入类型
          keyboardType: TextInputType.number,
          // 验证输入格式
          // inputFormatters: [ ],
          // 用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
          decoration: const InputDecoration(
            labelText: "Prices",
            hintText: "商品销售价格，单位为元" ,
            prefixIcon: Icon(Icons.info)
          ),
          // 获取输入数据内容 通过 controller 获取
          controller: _pricesController,
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            TextButton(onPressed: (){
              // 清除 除 code 的所有输入框
              _nameController.clear();
              _countController.clear();
              _pricesController.clear();
            }, child: const Text("清除")),
            TextButton(onPressed: (){
              _addgoods();
              }, child: const Text("提交"),
            style: TextButton.styleFrom(backgroundColor: Colors.red),)
          ],
           // 子组件 在 row中的对齐方式
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        )
      ],
      // 子组件 在 cloumn中的对齐方式
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),),
);
}
}