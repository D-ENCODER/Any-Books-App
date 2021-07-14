import 'package:any_books/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Programming extends StatefulWidget {
  const Programming({Key? key}) : super(key: key);

  @override
  _ProgrammingState createState() => _ProgrammingState();
}

class _ProgrammingState extends State<Programming> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('programming').snapshots(),
              builder: (context, snapshot) {
                final messages = snapshot.data!.docs;
                List<Container> messageWidgets = [];
                for (var message in messages) {
                  final bookName = message['name'];
                  final bookUrl = message['url'];
                  final bookDetails = message['details'];
                  final author = message['author'];
                  final aboutAuthor = message['aboutauthor'];
                  final publisher = message['publisher'];
                  final language = message['language'];
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsPage(
                                bookUrl: bookUrl,
                                bookName: bookName,
                                bookdetails: bookDetails,
                                bookauthor: author,
                                aboutAuthor: aboutAuthor,
                                languagedetails: language,
                                pagesdetails: pages,
                                publishername: publisher,
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
                              style: TextStyle(fontSize: 20),
                              overflow: TextOverflow.ellipsis,
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
    );
  }
}
