import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bug_issues.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({Key? key}) : super(key: key);

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  toast(String msg, Toast toast, ToastGravity toastGravity, Color colors) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toast,
      gravity: toastGravity,
      backgroundColor: colors,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  final _firestore = FirebaseFirestore.instance;
  String messagetext = '';
  String name = '';
  String emailid = '';
  double rate = 0;
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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.width) / 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Email :-',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        emailid = value;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: kTextFeildDecoration.copyWith(
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Name :-',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        name = value;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: kTextFeildDecoration.copyWith(
                        hintText: 'Enter your Name',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Ratings :-',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0.5,
                    glowColor: Color(0xffEAF9FE),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Color(0xff478CA8),
                    ),
                    onRatingUpdate: (rating) {
                      rate = rating;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Comment :-',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      minLines: 5,
                      maxLines: 50,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        messagetext = value;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: kTextFeildDecoration.copyWith(
                        hintText: 'Comment your feedback',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RoundedButton(
                colour: Color(0xff478CA8),
                title: 'SEND',
                onPressed: () {
                  if (rate != 0 &&
                      name != '' &&
                      emailid != '' &&
                      messagetext != '') {
                    _firestore.collection('feedback').add(
                      {
                        'comments': messagetext,
                        'email': emailid,
                        'name': name,
                        'ratings': rate,
                      },
                    );
                    toast('Thanks for your feedback', Toast.LENGTH_LONG,
                        ToastGravity.BOTTOM, Colors.black);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => super.widget,
                      ),
                    );
                  } else {
                    toast('Please fill the whole form', Toast.LENGTH_SHORT,
                        ToastGravity.BOTTOM, Colors.black);
                  }
                })
          ],
        ),
      ),
    );
  }
}
