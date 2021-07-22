import 'package:any_books/Terms_and_conditions.dart';
import 'package:any_books/bug_issues.dart';
import 'package:any_books/privacy_policy.dart';
import 'package:any_books/splash.dart';
import 'package:any_books/suggest.dart';
import 'package:any_books/topics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feedback.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAF9FE),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                _auth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('login', false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return IsUserLoggedIn();
                    },
                  ),
                );
              },
              icon: Icon(Icons.logout))
        ],
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Color(0xff478CA8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text('ANY BOOKS'),
        ),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MyTopicsWidget();
                  },
                ),
              );
            },
            child: MyCard(
              location: 'assets/topics.png',
              title: 'Topics',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PrivacyPolicy();
                  },
                ),
              );
            },
            child: MyCard(
              location: 'assets/topics2.png',
              title: 'Privacy Policy',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TermsAndConditions();
                  },
                ),
              );
            },
            child: MyCard(
              location: 'assets/topics3.png',
              title: 'Terms And Conditions',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BugIssue();
                  },
                ),
              );
            },
            child: MyCard(
              location: 'assets/topics6.png',
              title: 'Bug Issue',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FeedbackWidget();
                  },
                ),
              );
            },
            child: MyCard(
              location: 'assets/topics7.png',
              title: 'Feedback',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Suggestions();
                  },
                ),
              );
            },
            child: MyCard(
              location: 'assets/topics9.png',
              title: 'Suggest some books',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: Color(0xffEAF9FE),
                      appBar: AppBar(
                        toolbarHeight: 80,
                        backgroundColor: Color(0xff478CA8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        title: Align(
                          alignment: Alignment.center,
                          child: Text('ANY BOOKS'),
                        ),
                      ),
                      body: Center(
                          child: Text(
                        'Comming Soon.....',
                        style: TextStyle(fontSize: 22),
                      )),
                    );
                  },
                ),
              );
            },
            child: MyCard(
              location: 'assets/topics8.png',
              title: 'Donate Us',
            ),
          ),
          GestureDetector(
            onTap: () {
              Alert(
                context: context,
                style: AlertStyle(
                  isOverlayTapDismiss: false,
                  backgroundColor: Color(0xff478CA8),
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
                    onPressed: () => SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop'),
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
            },
            child: MyCard(
              location: 'assets/topics5.png',
              title: 'Exit',
            ),
          ),
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String location;
  final String title;
  const MyCard({Key? key, required this.title, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Color(0xff000000),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(location),
            ),
            Expanded(
              flex: 1,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
