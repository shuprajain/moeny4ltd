// TODO Implement this library.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:money4/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CardRegistration extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}



class _MyHomePageState extends State<CardRegistration> {
  String filePath = 'assets/files/test.html';
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Verification')),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _loadHtmlFromAssets();
        },
        navigationDelegate: (action) {
          print(action);
          // logger.i(action.url);
          // if (action.url ==
          //     "https://my.nebeus.com/login/#/sign-in") {
          //   return  Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ThankYouPage()),
          //   );
          // } else {
          //   //  pr.show();
          //   return NavigationDecision.navigate;
          // }
        },
        debuggingEnabled: true,

      ),

    );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}