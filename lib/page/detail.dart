/*
详细显示 所有商品的信息


 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DetailUserInfo extends StatefulWidget {
  const DetailUserInfo({Key? key}) : super(key: key);

  @override
  _DetailUserInfoState createState() => _DetailUserInfoState();
}

class _DetailUserInfoState extends State<DetailUserInfo> {
  final goodsList = [];

  // 初始化方法
  @override
  void initState() {
    super.initState();
    _get_all_goods();
  }

  // 获取 货物的所有数据
  // ignore: non_constant_identifier_names
  void _get_all_goods() async {
    String url = "http://139.155.16.210:8000/depot/";
    Dio dio = Dio();
    try {
      Response _rep = await dio.get(url);
      if (_rep.statusCode.toString() == "200") {
        print(_rep.toString());
        setState(() {
          goodsList.addAll(_rep.data);
          print(goodsList.length.toString());
          print(goodsList[0]["name"]);
        });
      }
    } on Exception catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WY_depot"),
      ),
      body: Center(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
            // 避免 ListView 在 column 中大小尺寸出错， 使用 expanded 来控制显示大小
            Expanded(
                /*SingleChildScrollView  与 expaned () 不可兼容 */
                child: ListView.builder(
                    //item 高度会适配 item填充的内容的高度
                    shrinkWrap: true, // use
                    itemExtent: 60.0,
                    itemCount: goodsList.length,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.dehaze),
                        subtitle:
                            Text("价格：" + goodsList[index]["prices"].toString()),
                        title: Text(goodsList[index]["name"]),
                        // 跳转到 商品详情页面
                        onTap: () {
                          Navigator.pushNamed(context, '/add_goods',
                              arguments: {"code": goodsList[index]});
                        },
                        trailing: const Icon(Icons.arrow_forward_ios),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        // 图片是否是 列表中的一部分
                        enabled: true,
                      );
                    })),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
