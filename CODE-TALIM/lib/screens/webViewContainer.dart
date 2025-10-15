import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer>
    with AutomaticKeepAliveClientMixin {
  var _url;
  final _key = UniqueKey();
  num position = 1;
  Widget refresh;
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    super.setState(() {
      new WebViewContainer("http://google.com");
    });
  }

  _WebViewContainerState(this._url);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: refreshList,
            key: refreshKey,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: IndexedStack(
                      index: position,
                      children: [
                        WebView(
                          key: _key,
                          initialUrl: _url,
                          onPageFinished: doneLoading,
                          onPageStarted: startLoading,
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                        Container(
                          color: Colors.black,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 11),
                                child: Image.asset(
                                  'assets/icone.png',
                                  height: 200,
                                ),
                              ),
                              LinearProgressIndicator(),
                            ],
                          )),
                        ),
                      ],
                    )))));
  }

  @override
  bool get wantKeepAlive => true;
}
