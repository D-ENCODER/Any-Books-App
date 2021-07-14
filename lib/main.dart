import 'package:any_books/categories/harry_potter.dart';
import 'package:any_books/categories/programming.dart';
import 'package:any_books/categories/space.dart';
import 'package:any_books/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: MyCustomSplashScreen(),
    );
  }
}

class TopicsWidget extends StatefulWidget {
  const TopicsWidget({Key? key}) : super(key: key);

  @override
  _TopicsWidgetState createState() => _TopicsWidgetState();
}

class _TopicsWidgetState extends State<TopicsWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Center(
            child: Text('ANY BOOKS'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CategoriesWidget(
                title: 'Space Exploration',
                category: SpaceExploration(),
              ),
              SizedBox(),
              CategoriesWidget(
                title: 'Programming',
                category: Programming(),
              ),
              SizedBox(),
              CategoriesWidget(
                title: 'Harry Potter',
                category: Harrypotter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoriesWidget extends StatelessWidget {
  String title;
  Widget category;
  CategoriesWidget({Key? key, required this.title, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            blurRadius: 25,
            offset: Offset(5, 10),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
          category,
        ],
      ),
    );
  }
}
