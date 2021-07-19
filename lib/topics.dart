import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'details.dart';

class MyTopicsWidget extends StatefulWidget {
  const MyTopicsWidget({Key? key}) : super(key: key);

  @override
  _MyTopicsWidgetState createState() => _MyTopicsWidgetState();
}

class _MyTopicsWidgetState extends State<MyTopicsWidget> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('topics').snapshots(),
          builder: (context, snapshot) {
            final messages = snapshot.data!.docs;
            List<Column> messageWidgets = [];
            for (var message in messages) {
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
                                body: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StreamBuilder<QuerySnapshot>(
                                          stream: _firestore
                                              .collection(topictitle)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            final messages =
                                                snapshot.data!.docs;
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
                                              final language =
                                                  message['language'];
                                              final pages = message['pages'];
                                              final pdf = message['pdf'];
                                              final messageWidget = Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 10,
                                                ),
                                                padding: EdgeInsets.all(10),
                                                height: 200,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: GestureDetector(
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
                                                        height: 150,
                                                        width: 140,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          '$bookName',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              messageWidgets.add(messageWidget);
                                            }
                                            return Row(
                                              children: messageWidgets,
                                            );
                                          }),
                                    ],
                                  ),
                                ),
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