import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:async';
import 'package:TALIM/screens/NavScreen.dart';
import 'package:TALIM/screens/TourScreen.dart';
import 'dart:math';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AfterSplash()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/intro.gif",
                gaplessPlayback: true, fit: BoxFit.fill)));
  }
}

class AfterSplash extends StatefulWidget {
  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  int selectedPage;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to TALIM',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/menu': (context) => MenuScreen(),
        '/menu/nav': (context) => NavScreen(selectedPage),
        '/tour': (context) => TourScreen(
            "https://legation.org/wp-content/uploads/2020/05/talim_360_light/"),
      },
    );
  }
}

@override
void playHandlerAr() async {
  if (isPlaying) {
    player.stop();
    player = await cache.play('WelcomeAR.mp3');
    isPlaying = true;
    isPaused = false;
  } else {
    player = await cache.play('WelcomeAR.mp3');
    isPlaying = true;
    isPaused = false;
  }
}

@override
void playHandlerEN() async {
  if (isPlaying) {
    player.stop();
    player = await cache.play('WelcomeENG.mp3');
    isPlaying = true;
    isPaused = false;
  } else {
    player = await cache.play('WelcomeENG.mp3');
    isPlaying = true;
    isPaused = false;
  }
}

@override
showAlertDialogAr(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text(
      "إِلْغَاء",
      style: TextStyle(fontSize: 16),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "التّالي",
      style: TextStyle(fontSize: 16),
    ),
    onPressed: () {
      Navigator.pushNamed(context, '/menu');
      Navigator.of(context, rootNavigator: true).pop();
      playHandlerAr();

      isPaused = false;
    },
  );
  @override

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
    backgroundColor: Colors.blue[50],
    content: Text(
        "'مَرْحَبًا بِكَ فِي تَطْبِيقْ 'مُتْحَفُ المُفَوَضِيَّة الأَمْرِيكِيَّة بِطَنْجَة"
        "  لِلْهَوَاتِفِ المَحْمُولَة! لَلْحُصُول عَلَى أَفْضَلِ تَجْرِبَة، يُنصَحُ بِاسْتِعْمَالِ سَمّاعَات الأُذُن وَ ضَبْطُ الصَوْتِ عَلَى مُسْتَوى 50% أَوْ أَقَل قَبْلَ الضَغْط عَلَى التّالِي."),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

@override
showAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(fontSize: 18),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Continue",
      style: TextStyle(fontSize: 18),
    ),
    onPressed: () {
      Navigator.pushNamed(context, '/menu');
      Navigator.of(context, rootNavigator: true).pop();
      playHandlerEN();

      isPaused = false;
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.blue[50],
    content: Text(
        "Welcome to the 'American Commission Museum' in Tangiers Mobile App! In order to get the best experience, it is recommended to use the earphones and set the sound at a level of 50% or less beforehand."),
    actions: [
      cancelButton,
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

@override
AudioCache cache = AudioCache();
AudioPlayer player;
bool isPlaying = false;
bool isPaused = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: RaisedButton(
                    color: Colors.black.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    onPressed: () {
                      imageToShow =
                          listImages[_random.nextInt(listImages.length)];
                      showAlertDialogAr(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Arabic   ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.record_voice_over),
                        Icon(
                          Icons.play_arrow,
                        ),
                        Text(
                          '   عَرَبِيّة',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: RaisedButton(
                    color: Colors.blue.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    onPressed: () {
                      imageToShow =
                          listImages[_random.nextInt(listImages.length)];
                      showAlertDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'English   ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.play_arrow,
                        ),
                        Icon(Icons.headset),
                        Text(
                          '   إِنْجْلِيزِيّة',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: BottomAppBar(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    elevation: 10.0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/menu');
                      imageToShow =
                          listImages[_random.nextInt(listImages.length)];
                    },
                    color: Colors.black.withOpacity(0.5),
                    child: Text('تَخَطِّي المُُقَدِّمَة',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  RaisedButton(
                    elevation: 10.0,
                    onPressed: () {},
                    color: Colors.black.withOpacity(0.0),
                    child: Image.asset(
                      "assets/icone.png",
                      height: 40,
                    ),
                  ),
                  RaisedButton(
                    elevation: 10.0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/menu');
                      imageToShow =
                          listImages[_random.nextInt(listImages.length)];
                    },
                    color: Colors.black.withOpacity(0.5),
                    child: Text(' Skip Intro ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@override
final listImages = [
  "assets/7.jpg",
  "assets/2.jpg",
  "assets/3.jpg",
  "assets/4.jpg",
  "assets/5.jpg",
  "assets/6.jpg"
];
@override
var _random = Random();

var imageToShow = listImages[_random.nextInt(listImages.length)];

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

@override
class _MenuScreenState extends State<MenuScreen> {
  pauseHandler() {
    if (isPaused) {
      player.resume();
    } else {
      player.pause();
    }
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(imageToShow.toString()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 60),
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(bottom: 22),
                  child: Image.asset(
                    "assets/icone.png",
                    height: 150,
                  ),
                ),
                Center(
                  child: Text(
                    ' TANGIER AMERICAN  LEGATION MUSEUM',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Center(
                    child: Text(
                      'مُتْحَفُ المُفَوَضِيَّة الأَمْرِيكِيَّة بِطَنْجَة',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blue.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavScreen(0)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'About Us   ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        "assets/information.png",
                        height: 30,
                      ),
                      Text(
                        '   مَنْ نَحْنُ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.blue.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavScreen(1)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Museum Tour   ',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        "assets/destination.png",
                        height: 30,
                      ),
                      Text(
                        '   جَولَةٌ فِي المُتْحَف',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.blue.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavScreen(2)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Audio Stops   ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        "assets/script.png",
                        height: 30,
                      ),
                      Text(
                        '   وَقَفَاتٌ صَوْتِيَّةٌ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavScreen(3)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Events Calendar   ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Image.asset(
                        "assets/appointment.png",
                        height: 30,
                      ),
                      Text(
                        '   بَرْنَامَجُ الأَنشِطَةِ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavScreen(4)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Feedback   ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Image.asset(
                        "assets/network.png",
                        height: 25,
                      ),
                      Text(
                        '   تَوَاصَلْ مَعَنَا',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  onPressed: () {
                    Navigator.pushNamed(context, '/tour');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Virtual Tour   ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Image.asset(
                        "assets/360.png",
                        height: 30,
                      ),
                      Text(
                        '   جَوَلاتٌ إفْتِرَاضِيَّةٌ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 15, bottom: 5),
            child: FloatingActionButton(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: Image.asset(
                  "assets/icone.png",
                  height: 40,
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (Route<dynamic> route) => false);
                }),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: PlayerButton(
              onPressed: pauseHandler,
              isTrue: isPaused,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isTrue;
  final Icon trueIcon;
  final Icon falseIcon;

  @override
  PlayerButton({
    @required this.onPressed,
    @required this.isTrue,
    this.trueIcon,
    this.falseIcon,
  });

  @override
  _PlayerButtonState createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<PlayerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5, right: 0),
      child: FlatButton(
        shape: CircleBorder(),

        /* shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.blue)), */
        textColor: Colors.white,
        color: Colors.black.withOpacity(0.5),
        onPressed: widget.onPressed,
        child: Icon(
          isPaused ? Icons.play_arrow : Icons.pause,
          size: 55.0,
        ),
        /* child: Icon(widget.isTrue ? widget.trueIcon : widget.falseIcon,
              style: TextStyle(fontSize: 16)), */
      ),
    );
  }
}

/*  @override
  bool get wantKeepAlive => true; */
