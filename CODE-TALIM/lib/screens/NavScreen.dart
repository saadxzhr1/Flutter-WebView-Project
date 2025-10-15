import 'package:flutter/material.dart';
import 'package:TALIM/main.dart';
import 'dart:math';
import 'package:TALIM/screens/webViewContainer.dart';
import 'package:TALIM/screens/ThirdScreen.dart';

class NavScreen extends StatefulWidget {
  final int selectedPage;
  NavScreen(this.selectedPage);

  @override
  _NavScreenState createState() => _NavScreenState(this.selectedPage);
}

class _NavScreenState extends State<NavScreen>
    with AutomaticKeepAliveClientMixin {
  var _selectedPage;
  _NavScreenState(this._selectedPage);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      initialIndex: _selectedPage,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text("", style: TextStyle(color: Colors.black)),
          ),
          backgroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 5,
            tabs: [
              Tab(
                child: Center(
                  child: Image.asset(
                    "assets/information.png",
                    height: 30,
                  ),
                ),
              ),
              Tab(
                child: Image.asset(
                  "assets/destination.png",
                  height: 30,
                ),
              ),
              Tab(
                child: Image.asset(
                  "assets/script.png",
                  height: 30,
                ),
              ),
              Tab(
                child: Image.asset(
                  "assets/appointment.png",
                  height: 30,
                ),
              ),
              Tab(
                child: Image.asset(
                  "assets/network.png",
                  height: 30,
                ),
              ),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            WebViewContainer(
              "https://app.legation.org/about",
            ),
            WebViewContainer("https://app.legation.org/museum-tour"),
            ThirdScreen("https://app.legation.org/audio"),
            WebViewContainer("https://app.legation.org/today"),
            WebViewContainer("https://app.legation.org/social"),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                elevation: 10.0,
                onPressed: () {
                  var _random = Random();
                  imageToShow = listImages[_random.nextInt(listImages.length)];
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/menu", (Route<dynamic> route) => false);
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
                  var _random = Random();
                  imageToShow = listImages[_random.nextInt(listImages.length)];
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (Route<dynamic> route) => false);
                },
                color: Colors.black.withOpacity(0.5),
                child: Image.asset(
                  "assets/icone.png",
                  height: 40,
                ),
              ),
              RaisedButton(
                elevation: 10.0,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/tour');
                },
                color: Colors.black.withOpacity(0),
                child: Image.asset(
                  "assets/360.png",
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
