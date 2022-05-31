import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:depot/common/rootbar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 扫描二维码
  Future<String> ss() async {
    var options = const ScanOptions(strings: {
      'cancel': "取消",
      'flash_on': "闪光灯",
      'flash_off': "关闭",
    }, android: AndroidOptions(useAutoFocus: false));
    // print("object");
    var result = await BarcodeScanner.scan(options: options);
    print(result.type);
    print(result.rawContent);
    print(result.format);
    print(result.formatNote);
    return result.rawContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        // 添加底部导航栏
        bottomNavigationBar: BottonBar(context),
        // BottomAppBar(
        //     child: Row(
        //   children: [
        //     IconButton(onPressed: (() {}), icon: const Icon(Icons.home)),
        //     const SizedBox(),
        //     IconButton(
        //         onPressed: (() {}),
        //         icon: const Icon(Icons.account_box)), // 中间位置空出
        //   ],
        //    // 设置 row 组件中， 分布逻辑
        //    mainAxisAlignment: MainAxisAlignment.spaceAround,   // 均分底部导航栏横向 空间
        // )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked, // 设置float button 的显示位置
        floatingActionButton: IconButton(
            color: Colors.blue, // 按钮icon的颜色
            // splashColor: Colors.blue,  // 点击时的背景颜色
            // highlightColor: Colors.blue,

            onPressed: (() {}),
            icon: const Icon(Icons.add)),
        body: Center(
          child: Column(children: [
            const SizedBox(
              height: 50.0,
            ),
            TextButton.icon(
                onPressed: () {
                  ss();
                },
                icon: const Icon(Icons.search),
                label: const Text("扫一扫"))
          ]),
        ));
  }
}
