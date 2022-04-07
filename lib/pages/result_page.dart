import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../User.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  var isFemale = User.gender.compareTo('Female') == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
            ),
            child: Row(
              children: [
                SizedBox(width: 100,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: (isFemale)
                        ? NetworkImage(
                            "https://365psd.com/images/istock/previews/1070/107005719-woman-icon-cartoon-single-avatar-people-icon.jpg")
                        : NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYsLQPyFDCB1z6o2YwlDjIo-YxqNzqaXYggg&usqp=CAU"),
                    radius: 80.0,

                  ),
                ),
                Column(
                  children: [

                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
