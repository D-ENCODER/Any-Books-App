import 'dart:async';
import 'dart:ui';
import 'package:any_books/forgot_password.dart';
import 'package:any_books/home.dart';
import 'package:any_books/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();

    controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation3 = Tween<double>(begin: .45, end: .4).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffEAF9FE),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            height: _height,
            child: Stack(
              children: [
                Positioned(
                  top: _height * (animation2.value + .6),
                  left: _width * .2,
                  child: CustomPaint(
                    painter: MyPainter(50),
                  ),
                ),
                Positioned(
                  top: _height * .98,
                  left: _width * .1,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value - 30),
                  ),
                ),
                Positioned(
                  top: _height * .5,
                  left: _width * (animation2.value + .8),
                  child: CustomPaint(
                    painter: MyPainter(30),
                  ),
                ),
                Positioned(
                  top: _height * animation3.value,
                  left: _width * (animation1.value + .1),
                  child: CustomPaint(
                    painter: MyPainter(60),
                  ),
                ),
                Positioned(
                  top: _height * .1,
                  left: _width * .8,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(top: _height * .1),
                        child: Text(
                          'ANY BOOKS',
                          style: TextStyle(
                            color: Colors.black.withOpacity(.7),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black.withOpacity(.7),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          component1(
                            Icons.email_outlined,
                            'Email...',
                            false,
                            true,
                            (value) {
                              email = value;
                            },
                          ),
                          component1(
                            Icons.lock_outline,
                            'Password...',
                            true,
                            false,
                            (value) {
                              password = value;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              component2(
                                'LOGIN',
                                2.58,
                                () async {
                                  if (email != '' && password != '') {
                                    Vibrate.feedback(FeedbackType.success);
                                    try {
                                      _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                    } catch (e) {
                                      Fluttertoast.showToast(msg: e.toString());
                                      Fluttertoast.showToast(
                                          msg: 'Invalid Email or password');
                                    }
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    await prefs.setBool('login', true);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HomeWidget();
                                        },
                                      ),
                                    );
                                  } else {
                                    Vibrate.feedback(FeedbackType.error);
                                    Fluttertoast.showToast(
                                        msg: 'Please fill all the fields');
                                  }
                                },
                              ),
                              SizedBox(width: _width / 20),
                              component2(
                                'Forgotten password!',
                                2.58,
                                () {
                                  Vibrate.feedback(FeedbackType.success);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ForgotPassword();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          component2(
                            'Create a new Account',
                            2,
                            () {
                              Vibrate.feedback(FeedbackType.success);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Register();
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: _height * .05),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword,
      bool isEmail, Function(String)? onChanged) {
    double _width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: _width / 8,
          width: _width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: _width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            style: TextStyle(color: Colors.black.withOpacity(.8)),
            cursorColor: Colors.black,
            obscureText: isPassword,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.black.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    double _width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: _width / 8,
            width: _width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.black.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(colors: [
        Color(0xff478CA8),
        Color(0xff71B1CB),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
