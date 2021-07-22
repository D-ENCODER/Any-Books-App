import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'details.dart';

class MyTopicsWidget extends StatefulWidget {
  const MyTopicsWidget({Key? key}) : super(key: key);

  @override
  _MyTopicsWidgetState createState() => _MyTopicsWidgetState();
}

class _MyTopicsWidgetState extends State<MyTopicsWidget> {
  late Timer timer;
  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  final _firestore = FirebaseFirestore.instance;
  bool showloader = true;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showloader,
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
          title: Align(
            alignment: Alignment.center,
            child: Text('ANY BOOKS'),
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('topics').snapshots(),
            builder: (context, snapshot) {
              final messages = snapshot.data!.docs;
              List<Column> messageWidgets = [];
              for (var message in messages) {
                showloader = false;
                final topictitle = message['title'];
                final messageWidget = Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
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
                                  body: StreamBuilder<QuerySnapshot>(
                                      stream: _firestore
                                          .collection(topictitle)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        final messages = snapshot.data!.docs;
                                        List<Container> messageWidgets = [];
                                        for (var message in messages) {
                                          final bookName = message['name'];
                                          final bookUrl = message['url'];
                                          final bookDetails =
                                              message['details'];
                                          final author = message['author'];
                                          final aboutAuthor =
                                              message['aboutauthor'];
                                          final publisher =
                                              message['publisher'];
                                          final language = message['language'];
                                          final pages = message['pages'];
                                          final pdf = message['pdf'];
                                          final messageWidget = Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 10,
                                            ),
                                            padding: EdgeInsets.all(10),
                                            height: 220,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  blurRadius: 25,
                                                  offset: Offset(5, 10),
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: GestureDetector(
                                              onLongPress: () {
                                                Fluttertoast.showToast(
                                                    msg: bookName);
                                              },
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return DetailsPage(
                                                        bookUrl: bookUrl,
                                                        bookName: bookName,
                                                        bookdetails:
                                                            bookDetails,
                                                        bookauthor: author,
                                                        aboutAuthor:
                                                            aboutAuthor,
                                                        languagedetails:
                                                            language,
                                                        pagesdetails: pages,
                                                        publishername:
                                                            publisher,
                                                        pdfurl: pdf,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    '$bookUrl',
                                                    height: 140,
                                                    width: 130,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      '$bookName',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                          messageWidgets.add(messageWidget);
                                        }
                                        return GridView(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            // crossAxisSpacing: 5.0,
                                            // mainAxisSpacing: 5.0,
                                          ),
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(
                                            parent:
                                                AlwaysScrollableScrollPhysics(),
                                          ),
                                          children: messageWidgets,
                                        );
                                      }),
                                );
                              },
                            ),
                          );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        padding: EdgeInsets.all(20),
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            myBoxShadow(),
                          ],
                          color: Color(0xff478CA8),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              topictitle,
                              style: screenTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );

                messageWidgets.add(messageWidget);
              }
              return Column(
                children: messageWidgets,
              );
            },
          ),
        ),
      ),
    );
  }
}

TextStyle screenTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.w900,
  );
}

BoxShadow myBoxShadow() {
  return BoxShadow(
    color: Color(0xff000000).withOpacity(0.3),
    blurRadius: 10,
    offset: Offset(5, 10),
  );
}
