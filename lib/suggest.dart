import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bug_issues.dart';


class Suggestions extends StatefulWidget {
  const Suggestions({ Key? key }) : super(key: key);

  @override
  _SuggestionsState createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
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
  String emailid = '';
  String bookname = '';
  String bookauthor = '';

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
                    'Book Name',
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
                        bookname = value;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: kTextFeildDecoration.copyWith(
                        hintText: 'Enter book Name',
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
                    'Author:-',
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
                        bookauthor = value;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: kTextFeildDecoration.copyWith(
                        hintText: 'Enter auther name',
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
                  if (bookname != '' &&
                      emailid != '' &&
                      bookauthor != '') {
                    _firestore.collection('suggestions').add(
                      {
                        'author': bookauthor,
                        'email': emailid,
                        'name': bookname,
                      },
                    );
                    toast('Thanks for your suggestion you will get your book soon.', Toast.LENGTH_LONG,
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