import 'package:flutter/material.dart';
import 'package:flutter_provider/generated/i18n.dart';
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
                child: Text('${S.of(context).add}'),
              );
            }),
            Store.connect<CounterModel>(builder: (context, snapshot, child) {
              print('================= home page counter widget rebuild');
              return Text('${snapshot.count}');
            }),
            Store.connect<CounterModel>(builder: (context, snapshot, child) {
              return RaisedButton(
                onPressed: snapshot.count > 0
                    ? () {
                        snapshot.decrement();
                      }
                    : null,
                child: Text('${S.of(context).minus}'),
              );
            }),
            Store.connect<UserModel>(builder: (context, snapshot, child) {
              print('================= home page name Widget rebuild');
              return Text('${Store.value<UserModel>(context).name}');
            }),
            TextField(controller: controller),
            Store.connect<UserModel>(builder: (context, snapshot, child) {
              return RaisedButton(
                child: Text('${S.of(context).change_name}'),
                onPressed: () {
                  snapshot.setName(controller.text);
                },
              );
            }),
            Store.connect<ConfigModel>(builder: (context, snapshot, child) {
              print('================= home page local Widget rebuild');
              return RaisedButton(
                onPressed: () => _openLanguageSelectMenu(context),
                child: Text(
                    '${mapSupportLocale[SupportLocale.values[snapshot.localIndex]]}'),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Center(child: Icon(Icons.color_lens)),
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
    return Store.connect<ConfigModel>(builder: (context, snapshot, child) {
      return ListView(
        children: themeColors.map((item) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(item),
            ),
            selected: snapshot.getThemeColor() == item,
            title: Text('Item $item'),
            onTap: () {
              print('Theme item $item');
              snapshot.setTheme(item);

              Navigator.of(context).pop();
            },
          );
        }).toList(),
      );
    });
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
      return Store.connect<ConfigModel>(builder: (context, snapshot, child) {
        return ListTile(
            title: Text("${mapSupportLocale[local]}"),
            onTap: () {
              snapshot.setLocal(index);
              Navigator.pop(context);
            },
            selected: snapshot.localIndex == index);
      });
    }).toList();
  }
}
