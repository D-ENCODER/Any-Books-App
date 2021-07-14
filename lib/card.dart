import 'package:flutter/material.dart';

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
      elevation: 25,
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
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
