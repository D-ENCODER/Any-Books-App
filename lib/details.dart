import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  DetailsPage({
    Key? key,
    required this.bookUrl,
    required this.bookName,
    required this.bookdetails,
    required this.aboutAuthor,
    required this.bookauthor,
    required this.languagedetails,
    required this.pagesdetails,
    required this.publishername,
    required this.pdfurl,
    language,
  }) : super(key: key);

  var bookUrl;
  var bookName;
  var bookauthor;
  var bookdetails;
  var aboutAuthor;
  var publishername;
  var languagedetails;
  var pagesdetails;
  var pdfurl;

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
        title: Center(
          child: Text('ANY BOOKS'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Color(0xff000000),
              elevation: 25,
              child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '$bookName',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Image.network(
                          '$bookUrl',
                          height: 200,
                          width: 160,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'About Book',
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('$bookdetails'),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            '\nPublisher: $publishername \nBook Language: $languagedetails \nBook pages: $pagesdetails pages'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'About Author',
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('$aboutAuthor'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SafeArea(
                        child: Scaffold(
                          body: Container(
                            child: SfPdfViewer.network(
                              '$pdfurl',
                              searchTextHighlightColor: Color(0xffEAF9FE),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                padding: EdgeInsets.all(20),
                height: 70,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 25,
                      offset: Offset(5, 10),
                    ),
                  ],
                  color: Color(0xff478CA8),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Read this book',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
