/*
抽离 booton navigatorbar 这个共有组件
抽离booton navigatorbar 必须实现PreferredSizeWidget
抽离头部和底部相同的代码为 layout 组件
*/
import 'package:depot/common/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                IconButton(
                    onPressed: (() {
                      Navigator.pushNamed(context, "/");
                    }),
                    icon: const Icon(Icons.home)),
                const SizedBox(),
                IconButton(
                    onPressed: (() async {
                      var t = await StorageOperation.get("test");
                      if (t != null) {
                        Navigator.pushNamed(context, "/userinfo");
                      } else {
                        Navigator.pushNamed(context, "/login");
                      }
                    }),
                    icon: const Icon(Icons.account_box)), // 中间位置空出
              ],
              // 设置 row 组件中， 分布逻辑
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 均分底部导航栏横向 空间
            ));
}

class MainAppbar extends AppBar {
  // 继承自自带 组件的
  MainAppbar(
    BuildContext context, // 上下文 ，必须
    // String titleName, // 因为所有页面的title 一致，可以直接写死，不再传入该title
    {
    Key? key,
    bool isCenterTitle = true, //是否居中显示title
    final actions, //右边部分，肯存放图标，文字等，可能还有点击事件，参数可选
    // final backIcon=const Icon(Icons.abc)
  }) : super(
          key: key,
          automaticallyImplyLeading: false, // 设置没有返回按钮
          backgroundColor: Colors.blue,
          toolbarHeight: 60.0,
          // title: const Text('Boziyoung Notes'),
          // 设置标题 左右间距 为 50
          // titleSpacing: 50,
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: TextButton(
                  onPressed: () {
                    Get.offAllNamed('/');
                  },
                  child: const Text(
                    'Mrs.Wang Grocery Store',
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                  )),
            ),
            const Expanded(child: SizedBox())
          ],
        );
}
