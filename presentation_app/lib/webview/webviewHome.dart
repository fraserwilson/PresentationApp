import 'package:flutter/material.dart';
import 'package:presentation_app/webview/wedviewNavigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'menu.dart';

class WebViewTester extends StatefulWidget {
  const WebViewTester({Key? key, required this.controller}) : super(key: key);
  final WebViewController controller;

  @override
  State<WebViewTester> createState() => _WebViewTesterState();
}

class _WebViewTesterState extends State<WebViewTester> {
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onNavigationRequest: (navigation) {
            final host = Uri.parse(navigation.url).host;
            if (host.contains('youtube.com')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Blocking navigation to $host',
                  ),
                ),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
        // Add from here...
        actions: [
          NavigationControls(controller: widget.controller),
          Menu(controller: widget.controller),
        ],
        // ...to here.
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: widget.controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              color: Colors.yellow,
              minHeight: 50,
            ),
        ],
      ),
    );
  }
}
