import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewNewsScreen extends StatelessWidget {

  final String url;

  ViewNewsScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url ,
    );
  }
}
