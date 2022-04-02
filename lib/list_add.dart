// リスト追加画面用Widget
import 'package:flutter/material.dart';

class ListAdd extends StatefulWidget {
  @override
  _ListAddState createState() => _ListAddState();
}

class _ListAddState extends State<ListAdd> {
  // 状態設定
  String _text = '';

  // 表示
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト追加'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Add List a Sample.',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 戻る（引数あり）
                  Navigator.of(context).pop(_text);
                },
                child: const Text(
                  'リスト追加',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // 戻る
                  Navigator.of(context).pop();
                },
                child: const Text('戻る'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
