import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class web extends StatefulWidget {
  String title;

  String url;

  web({Key key, this.title, this.url}) : super(key: key);

  @override
  _webState createState() => _webState();
}

class _webState extends State<web> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            padding: new EdgeInsets.all(15),
            onPressed: () {
              Navigator.pop(context, "");
            }),
        title: Text(
          widget.title,
          textAlign: TextAlign.left,
        ),
        centerTitle: false,
      ),
      withZoom: true,
      // 允许网页缩放
      withLocalStorage: true,
      // 允许LocalStorage
      withJavascript: true,
    ); // 允许执行js代码
  }
}
