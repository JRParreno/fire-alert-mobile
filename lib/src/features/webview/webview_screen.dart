import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.title,
    required this.url,
  });

  static const String routeName = '/webview-screen';
  final String url;
  final String title;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        title: widget.title,
      ),
      body: Container(
        color: Colors.white,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
