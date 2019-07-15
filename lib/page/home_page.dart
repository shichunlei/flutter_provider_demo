import 'package:flutter/material.dart';
import 'package:flutter_provider/store/index.dart';
import 'package:flutter_provider/store/model/config.dart';
import 'package:flutter_provider/store/model/counter.dart';
import 'package:flutter_provider/store/model/user.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$title')),
      body: Center(
        child: Column(
          children: <Widget>[
            Store.connect<CounterModel>(builder: (context, snapshot, child) {
              return RaisedButton(
                onPressed: () {
                  snapshot.increment();
                },
                child: Text('add'),
              );
            }),
            Store.connect<CounterModel>(builder: (context, snapshot, child) {
              print('first page counter widget rebuild');
              return Text('${snapshot.count}');
            }),
            Store.connect<CounterModel>(builder: (context, snapshot, child) {
              return RaisedButton(
                onPressed: snapshot.count > 0
                    ? () {
                        snapshot.decrement();
                      }
                    : null,
                child: Text('minus'),
              );
            }),
            Store.connect<UserModel>(builder: (context, snapshot, child) {
              print('first page name Widget rebuild');
              return Text('${Store.value<UserModel>(context).name}');
            }),
            TextField(
              controller: controller,
            ),
            Store.connect<UserModel>(builder: (context, snapshot, child) {
              return RaisedButton(
                child: Text('change name'),
                onPressed: () {
                  snapshot.setName(controller.text);
                },
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Center(child: Icon(Icons.group_work)),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (builder) {
                return _bottomSheetItem(context);
              });
        },
      ),
    );
  }

  Widget _bottomSheetItem(BuildContext context) {
    return ListView(
        // 生成一个列表选择器
        children: themeColors.map((item) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(item),
        ),
        selected: Store.value<ConfigModel>(context).getThemeColor() == item,
        title: Text('Item $item'),
        onTap: () {
          print('tapped item $item');
          Store.value<ConfigModel>(context).setTheme(item);

          Navigator.of(context).pop();
        },
      );
    }).toList());
  }
}
