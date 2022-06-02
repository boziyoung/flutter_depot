/*
抽离 booton navigatorbar 这个共有组件
抽离booton navigatorbar 必须实现PreferredSizeWidget
抽离头部和底部相同的代码为 layout 组件
*/
import 'package:flutter/material.dart';

class BottonBar extends BottomAppBar {
  BottonBar(
    BuildContext context, // 上下文， 必须的
    {
    Key? key,
  }) : super(
            key: key,
            color: Colors.white, //导航栏颜色
            shape:
                const CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞  思考这个 打孔的位置没有 具体显示位置
            child: Row(
              children: [
                IconButton(onPressed: (() {
                   Navigator.pushNamed(context, "/");
                }), icon: const Icon(Icons.home)),
                const SizedBox(),
                IconButton(
                    onPressed: (() {
                      Navigator.pushNamed(context, "/login");
                    }),
                    icon: const Icon(Icons.account_box)), // 中间位置空出
              ],
              // 设置 row 组件中， 分布逻辑
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 均分底部导航栏横向 空间
            ));
}
