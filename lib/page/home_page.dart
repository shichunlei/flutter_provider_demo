import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/generated/i18n.dart';
import 'package:flutter_provider/store/index.dart';
import 'package:flutter_provider/store/model/config.dart';
import 'package:flutter_provider/store/model/counter.dart';
import 'package:flutter_provider/store/model/user.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$title')),
      body: Container(
        child: Column(
          children: <Widget>[
            Store.connect<CounterModel>(builder:
                (BuildContext context, CounterModel snapshot, Widget child) {
              return RaisedButton(
                onPressed: () {
                  snapshot.increment();
                },
                child: Text('${S.of(context).add}'),
              );
            }),
            Store.connect<CounterModel>(builder:
                (BuildContext context, CounterModel snapshot, Widget child) {
              print('================= home page counter widget rebuild');
              return Text('${snapshot.count}');
            }),
            Store.connect<CounterModel>(builder:
                (BuildContext context, CounterModel snapshot, Widget child) {
              return RaisedButton(
                onPressed: snapshot.count > 0
                    ? () {
                        snapshot.decrement();
                      }
                    : null,
                child: Text('${S.of(context).minus}'),
              );
            }),
            Text('${Store.value<UserModel>(context).name}'),
            TextField(controller: controller),
            RaisedButton(
              child: Text('${S.of(context).change_name}'),
              onPressed: () {
                Store.value<UserModel>(context).setName(controller.text);
              },
            ),
            Store.connect<ConfigModel>(builder:
                (BuildContext context, ConfigModel snapshot, Widget child) {
              print('================= home page local Widget rebuild');
              return RaisedButton(
                onPressed: () => _openLanguageSelectMenu(context),
                child: Text(
                    '${mapSupportLocale[SupportLocale.values[snapshot.localIndex]]}'),
              );
            }),
            Divider(),
            Store.connect<ConfigModel>(
              builder:
                  (BuildContext context, ConfigModel snapshot, Widget child) {
                return ListTile(
                  title: Text(snapshot.getThemeText()),
                  trailing: CupertinoSwitch(
                    activeColor: Colors.green,
                    value: snapshot.getTheme(),
                    onChanged: (value) {
                      snapshot.setTheme(value);
                    },
                  ),
                );
              },
            ),
            Store.connect<ConfigModel>(
              builder:
                  (BuildContext context, ConfigModel snapshot, Widget child) {
                return Row(
                  children: <Widget>[
                    Flexible(
                      child: RadioListTile<String>(
                        value: "夜间模式", title: Text("夜间模式"),
                        groupValue: snapshot.getThemeText(),

                        /// 变化时回调
                        onChanged: (value) {
                          debugPrint('$value');
                          snapshot.setTheme('夜间模式' == value);
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile<String>(
                        value: "日间模式",
                        title: Text("日间模式"),
                        groupValue: snapshot.getThemeText(),
                        onChanged: (value) {
                          debugPrint('$value');
                          snapshot.setTheme('夜间模式' == value);
                        },
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountEmail: Text('1558053958@qq.com'),
                accountName: Text('scl'),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: NetworkImage(
                            'http://pic1.16pic.com/00/31/72/16pic_3172062_b.jpg'),
                        fit: BoxFit.cover)))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Center(child: Icon(Icons.color_lens)),
        onPressed: () {},
      ),
    );
  }

  /// 国际化
  void _openLanguageSelectMenu(context) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) => Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min, children: _items(context)),
            ));
  }

  List<Widget> _items(context) {
    return SupportLocale.values.map((local) {
      int index = SupportLocale.values.indexOf(local);
      return ListTile(
          title: Text("${mapSupportLocale[local]}"),
          onTap: () {
            Store.value<ConfigModel>(context).setLocal(index);
            Navigator.pop(context);
          },
          selected: Store.value<ConfigModel>(context).localIndex == index);
    }).toList();
  }
}
