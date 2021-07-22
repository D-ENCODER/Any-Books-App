import 'package:any_books/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyIntroScreen extends StatefulWidget {
  @override
  _MyIntroScreenState createState() => _MyIntroScreenState();
}

class _MyIntroScreenState extends State<MyIntroScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return IsUserLoggedIn();
          },
        ),
      );
    } else {
      await prefs.setBool('seen', true);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OnBoardingPage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  bool kIsWeb = identical(0, 0.0);

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => IsUserLoggedIn()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, fontWeight: FontWeight.w600);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xffffffff),
      imagePadding: EdgeInsets.zero,
    );

    return WillPopScope(
      onWillPop: () async {
        Alert(
          context: context,
          style: AlertStyle(
            animationDuration: Duration(milliseconds: 500),
          ),
          type: AlertType.none,
          title: "EXIT APP ?",
          desc: "Are you sure you want to exit the app ?",
          buttons: [
            DialogButton(
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              color: Colors.grey[700],
            ),
            DialogButton(
              child: Text(
                "No",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.grey[500],
            )
          ],
        ).show();
        return true;
      },
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Color(0xff544ECC),
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
            ),
          ),
        ),
        globalFooter: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xff544ecc),
            ),
            child: const Text(
              'Let\s go right away!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Welcome User,",
            body:
                "Thank you for downloading our app you will find amazing stuff here and this app will increase your IQ to a much high extent",
            image: _buildImage('images/welcome.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Light And Dark theme added",
            body:
                "This app is available in both light and dark themes, and user can always toggle between the two anytime anywhere!!",
            image: _buildImage('images/theme.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Do Not Disturb Feature Added",
            body:
                "You always need an app that attracts you and not divert in any useless topic so for that reason we have added Do not Disturb mode",
            image: _buildImage('images/donotdisturb.png'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text(
          'Skip',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        animationDuration: 1500,
        done: const Text(
          'Done',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.white,
          activeColor: Color(0xffA9A1E3),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Color(0xff544ECC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
