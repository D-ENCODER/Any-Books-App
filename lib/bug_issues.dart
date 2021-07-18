import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BugIssue extends StatefulWidget {
  const BugIssue({Key? key}) : super(key: key);

  @override
  _BugIssueState createState() => _BugIssueState();
}

class _BugIssueState extends State<BugIssue> {
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
  String message = '';
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
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.width) / 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Email:-'),
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
                    Text('Message :-'),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 50,
                        minLines: 5,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          message = value;
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: kTextFeildDecoration.copyWith(
                          hintText: 'Brief note about the bug',
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
                    if (message != '' && emailid != '') {
                      _firestore.collection('bug').add(
                        {
                          'details': message,
                          'email': emailid,
                        },
                      );
                      toast('Reported Successfully', Toast.LENGTH_LONG,
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
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour, required this.title, required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed as void Function()?,
          minWidth: 300.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

const kTextFeildDecoration = InputDecoration(
  hintText: 'Enter your password',
  hintStyle: TextStyle(color: Color(0xff71B1CB)),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff478CA8), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff478CA8), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
