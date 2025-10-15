import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TourScreen extends StatefulWidget {
  final url;

  TourScreen(this.url);

  @override
  createState() => _TourScreenState(this.url);
}

class _TourScreenState extends State<TourScreen>
    with AutomaticKeepAliveClientMixin {
  var _url;
  final _key = UniqueKey();
  num position = 1;

  doneLoading(String A) async {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  _TourScreenState(this._url);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                elevation: 10.0,
                onPressed: () {
                  Navigator.pushNamed(context, '/menu');
                },
                color: Colors.black.withOpacity(0.5),
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              RaisedButton(
                elevation: 10.0,
                onPressed: () {
                  Navigator.pushNamed(context, "/");
                },
                color: Colors.black.withOpacity(0.5),
                child: Image.asset(
                  "assets/icone.png",
                  height: 40,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: IndexedStack(
            index: position,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: WebView(
                  key: _key,
                  initialUrl: _url,
                  onPageFinished: doneLoading,
                  onPageStarted: startLoading,
                  javascriptMode: JavascriptMode.unrestricted,
                ),
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
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
