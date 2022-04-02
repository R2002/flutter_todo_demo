import 'package:flutter/material.dart';
import 'package:untitled/list_add.dart';
import 'package:untitled/list_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 状態設定
  List<String> todoList = [];

  // 初期化
  @override
  void initState() {
    super.initState();
    // 初期化時に状態呼び出しを行う
    readPreferences();
  }

  // 状態呼び出し
  @override
  void readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // SharedPreferencesはList<String>に対応。それ以上複雑になる場合は、JSON化を推奨。
    final List<String>? items = prefs.getStringList('items'); // null許容
    if (items != null) {
      todoList = items;
    }
    print('read Preferences');
  }

  // 状態書き込み
  @override
  void writePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items', todoList);
    print('write Preferences');
  }

  // 表示
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト一覧画面'),
      ),
      body: todoList.isNotEmpty
          ? ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(todoList[index]),
                    subtitle: Text("No.$index"),
                    leading: IconButton(
                      onPressed: () async {
                        // 新規画面に遷移し、引数をinputTextに入れる
                        final inputText = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            // 遷移先の画面としてリスト追加画面を指定
                            return ListEdit(todoList[index]);
                          }),
                        );
                        // inputTextがnull（またはpopの引数なし）の場合
                        if (inputText != null) {
                          setState(() {
                            // リスト変更（list上にすでにindexを持っているため、出力のinputTextに変更できる）
                            todoList[index] = inputText;
                          });
                          // 記録変更
                          writePreferences();
                        }
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          // indexを指定して削除
                          todoList.removeAt(index);
                        });
                        // 記録変更
                        writePreferences();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('リストがありません'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final inputText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ListAdd();
            }),
          );
          if (inputText != null) {
            setState(() {
              // リスト追加
              todoList.add(inputText);
            });
            // 記録変更
            writePreferences();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
