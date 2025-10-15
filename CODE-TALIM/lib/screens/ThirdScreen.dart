import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThirdScreen extends StatefulWidget {
  final url;

  ThirdScreen(this.url);
  @override
  _ThirdScreenState createState() => _ThirdScreenState(this.url);
}

class _ThirdScreenState extends State<ThirdScreen>
    with AutomaticKeepAliveClientMixin {
  WebViewController webView;
  String url = "https://app.legation.org/today";
  bool showTextField = true;
  final myController = TextEditingController();
  var _url;

  Widget _buildFloatingSearchBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 11, right: 11),
      child: RaisedButton(
        child: Icon(Icons.search),
        color: Colors.blueGrey[600],
        onPressed: () {
          if (myController.text == '') {
            searchAlertDialog(context);
          } else {
            _url = "https://app.legation.org/${myController.text}";
            webView.loadUrl(_url);
            _ThirdScreenState(this._url);
            FocusScope.of(context).requestFocus(new FocusNode());
          }
          /* FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          } */
        },
      ),
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 5, right: 11),
          child: TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Code',
            ),
            controller: myController,
            onFieldSubmitted: (term) {
              _url = "https://app.legation.org/${myController.text}";
              webView.loadUrl(_url);
              FocusScope.of(context).requestFocus(new FocusNode());
              _ThirdScreenState(this._url);
            },
            style: TextStyle(fontSize: 21, color: Colors.black),
            cursorColor: Colors.blue,
            keyboardAppearance: Brightness.dark,
            onTap: () {
              showTextField = true;
            },
          ),
        ),
      ),
    );
  }

  /*  Widget _buildFloatingSearch() {
    return Row(children: [_buildFloatingSearchBtn(), _buildTextField()]);
  } */

  searchAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        _url = "https://app.legation.org/audio";
        webView.loadUrl(_url);
        Navigator.of(context, rootNavigator: true).pop();
        _ThirdScreenState(this._url);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
          "مرحبا، هنا يمكنك استخدام الرموز التي تجدها حول (داخل) المتحف، لا يزال بامكانك الوصول الى كل المحتوى المتاح في اي قت من القوائم، استمتع!"
          "Welcome, here you can use the codes that you find around (inside) the museum. You can still access all the available content at any time from the Menu, Enjoy!"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  num position = 1;

  doneLoading(String A) {
    setState(() {
      position = 0;
      _ThirdScreenState(this._url);
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
      _ThirdScreenState(this._url);
    });
  }

  final _key = UniqueKey();
  _ThirdScreenState(this._url);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: <Widget>[
                  showTextField ? _buildTextField() : Container(),
                  _buildFloatingSearchBtn(),
                ],
              ),
            ),
          ),
          Expanded(
              child: IndexedStack(index: position, children: [
            /*Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                      "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
                ),*/

            WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url,
              onPageFinished: doneLoading,
              onPageStarted: startLoading,
              onWebViewCreated: (WebViewController controller) {
                webView = controller;
              },

              /* initialHeaders: {},
                    initialOptions: WebViewGroupOptions(
                        crossPlatform: WebViewOptions(
                      debuggingEnabled: false,
                      cacheEnabled: false,
                    )),
                    onWebViewCreated: (WebViewController controller) {
                      webView = controller;
                    }, */
              /* onLoadStart: (WebViewController controller, String url) {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onPageFinished:
                        (WebViewController controller, String url) async {
                      setState(() {
                        this.url = url;
                      });
                    },*/
              /* onProgressChanged:
                        (WebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    }, */
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
          ]))
        ]));
  }

  @override
  bool get wantKeepAlive => true;
}
