// リスト追加画面用Widget
import 'package:flutter/material.dart';

class ListEdit extends StatefulWidget {
  // 開始時の引数を定義
  ListEdit(this.text);

  // 状態設定
  String text;

  @override
  _ListEditState createState() => _ListEditState();
}

class _ListEditState extends State<ListEdit> {
  // 状態設定
  String? _text;

  // 表示
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト編集'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TextFieldはinitialValueがないため、TextFormField
            TextFormField(
              initialValue: widget.text,
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'タスク名を入力してください',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // widget.textがnullでなければ変更
                  _text ??= widget.text;
                  // 戻る（引数あり）
                  Navigator.of(context).pop(_text);
                },
                child: const Text(
                  '編集',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
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
