import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../User.dart';
import 'easy.dart';
import 'result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initial Selected Value
  String dropdownvalue_1 = 'GENDER';
  String dropdownvalue_2 = 'ACTIVITY';

  var surnameController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var wController = TextEditingController();
  var hController = TextEditingController();
  int act_index=0 ;
  String gen ='';
  var pad = const EdgeInsets.only(top: 6.0, bottom: 6.0);
  // List of items in our dropdown menu
  var gender = ['GENDER', 'Male', 'Female'];
  var action = [
    'ACTIVITY',
    'Stationary or never exercise',
    'Light exercise (1-3 days/week)',
    'Medium exercise (3-5 days/week)',
    'Hard exercise (6-7 days/week)',
    'Hard exercise for training (everyday)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade100,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'WELCOME TO',
                  style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'ARLRDBD',
                      color: Colors.indigo.shade900),
                ),
                Text(
                  'BMR & TDEE CALCULATOR',
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'ARLRDBD',
                      color: Colors.indigo.shade700),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://health.clevelandclinic.org/wp-content/uploads/sites/3/2021/09/Weightloss-1296684910-770x533-1.jpg"),
                    radius: 100.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildInput('name'),
                      buildInput('surname'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: buildNumInput('age')),
                          Expanded(child: buildGenderList()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: build_W_or_H_Input('weigh (kg)')),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(child: build_W_or_H_Input('height (cm)')),
                        ],
                      ),
                      buildActivityList(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () => handleClickBTN(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Let's go",
                                style: TextStyle(fontSize: 22, fontFamily: 'ARLRDBD'),
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildActivityList() {
    return Padding(
      padding: pad,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1.0, color: Colors.black54),
        ),
        child: DropdownButton(
          underline: Container(
            height: 1,
            color: Colors.indigo,
          ),
          isExpanded: true,
          style: TextStyle(color: Colors.grey.shade800),
          dropdownColor: Colors.indigoAccent.shade100,
          // Initial Value
          value: dropdownvalue_2,
          // Down Arrow Icon
          icon: Icon(Icons.keyboard_arrow_down),
          // Array list of items
          items: action.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(items),
              ),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            if (action.indexOf(newValue!) != 0) {
              setState(() {
                dropdownvalue_2 = newValue;
                User.activity_index = action.indexOf(newValue);
              });
            }
          },
        ),
      ),
    );
  }

  Padding buildGenderList() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1.0, color: Colors.black54),
        ),
        child: DropdownButton(
          underline: Container(
            height: 1,
            color: Colors.indigo,
          ),
          isExpanded: true,
          style: TextStyle(color: Colors.grey.shade800),
          dropdownColor: Colors.indigoAccent.shade100,
          // Initial Value
          value: dropdownvalue_1,
          // Down Arrow Icon
          icon: Icon(Icons.keyboard_arrow_down),
          // Array list of items
          items: gender.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(items),
              ),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            if (gender.indexOf(newValue!) != 0) {
              setState(() {
                dropdownvalue_1 = newValue;
                User.gender = newValue;
              });
            }
          },
        ),
      ),
    );
  }

  Padding buildNumInput(String str) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 6.0),
      child: TextField(
        controller:ageController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          border: OutlineInputBorder(),
          label: Text(str.toUpperCase()),
          //hintText: 'Enter your age',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 2,
      ),
    );
  }
  Padding build_W_or_H_Input(String str) {
    var isW = (str.compareTo('weigh (kg)') == 0);
    return Padding(
      padding: pad,
      child: TextField(
        controller: (isW)?wController:hController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          border: OutlineInputBorder(),
          label: Text(str.toUpperCase()),
          //hintText: 'Enter your age',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 3,
      ),
    );
  }

  Padding buildInput(String lb) {
    var isName = lb.compareTo('name')==0;
    return Padding(
      padding: pad,
      child: TextField(
        controller: (isName)?nameController:surnameController,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          label: Text(lb.toUpperCase()),
          //hintText: 'Enter your surname',
        ),
      ),
    );
  }

  void handleClickBTN() {
    if(nameController.text == ' ' || surnameController.text==' ' || ageController==0
        || wController ==' ' || hController==' ' || User.gender == ' ' || User.activity_index < 0 ){
      showDialog(context: context,  barrierDismissible: false,builder: (BuildContext context){
        return AlertDialog(
          title: Text('ERROR'),
          content:Text('Invalid input'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      });
    }else{
      User.name = nameController.text;
      User.surname = surnameController.text;
      User.age = int.tryParse(ageController.text)!;
      User.weigh = int.tryParse(wController.text) as double;
      User.height = int.tryParse(hController.text) as double;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultPage())
      );
    }
  }
}
