import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_flutter_asset/jaguar_flutter_asset.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// import 'dart:io';

// import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  final server = Jaguar();
  server.addRoute(serveFlutterAssets());
  await server.serve();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       child: MaterialApp(
//         title: 'Material App',
//         home: WebviewScaffold(
//           url:
//               'http://192.168.1.137:3000/viewer.html?urn=dXJuOmFkc2sub2JqZWN0czpvcy5vYmplY3Q6emhlaHM1amsxc2dzYzNlYjh1bDBhemg0eDZud2ExdWlfdHV0b3JpYWxfYnVja2V0L3JzdF9iYXNpY19zYW1wbGVfcHJvamVjdC5ydnQ=',
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Autodesk Forge Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Autodesk Forge Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final String url =
  //     'http://192.168.1.137:3000/viewer.html?urn=dXJuOmFkc2sub2JqZWN0czpvcy5vYmplY3Q6emhlaHM1amsxc2dzYzNlYjh1bDBhemg0eDZud2ExdWlfdHV0b3JpYWxfYnVja2V0L3JzdF9iYXNpY19zYW1wbGVfcHJvamVjdC5ydnQ=';
  final String url = 'http://127.0.0.1:8080/';
  WebViewController _webViewController;
  String value;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.80,
        // width: MediaQuery.of(context).size.width * 1,
        // padding: EdgeInsets.all(8),
        width: double.infinity,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,

          initialUrl: url,
          // javascriptChannels: {
          //   JavascriptChannel(
          //     name: 'messageHandler',
          //     onMessageReceived: (message) {
          //       setState(() {
          //         value = message.message;
          //       });
          //     },
          //   )
          // },
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            // _loadHtmlFromAssets();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _webViewController.evaluateJavascript('home()');
        },
        child: value == null ? Icon(Icons.home_outlined) : Text(value),
      ),
    );
  }

  void _loadHtmlFromAssets() async {
    String html = await rootBundle.loadString('assets/viewer.html');
    _webViewController.loadUrl(Uri.dataFromString(html,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

// class WebViewExample extends StatefulWidget {
//   @override
//   WebViewExampleState createState() => WebViewExampleState();
// }

// class WebViewExampleState extends State<WebViewExample> {
//   @override
//   void initState() {
//     super.initState();
//     // Enable hybrid composition.
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       // initialUrl:
//       //     'http://192.168.1.137:3000/viewer.html?urn=dXJuOmFkc2sub2JqZWN0czpvcy5vYmplY3Q6emhlaHM1amsxc2dzYzNlYjh1bDBhemg0eDZud2ExdWlfdHV0b3JpYWxfYnVja2V0L3JzdF9iYXNpY19zYW1wbGVfcHJvamVjdC5ydnQ=',
//       initialUrl: 'http://192.168.1.137:3000',
//     );
//   }
// }
