import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../User.dart';
import 'home_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  var isFemale = User.gender.compareTo('Female') == 0;
  var style1 =
      TextStyle(fontFamily: 'ARLRDBD', fontSize: 20, color: Colors.black54);
  var style2 = TextStyle(fontSize: 24, color: Colors.white);
  var _isLoading = false;
  late double bmr;
  late double tdee;
  List<String> mealName = ['Breakfast', 'Lunch', 'Dinner'];
  List<int> mealCalorie = [];

  @override
  void initState() {
    super.initState();
    _Calculate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Header(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildBMRorTDEE('BMR'),
                        buildBMRorTDEE('TDEE'),
                      ],
                    ),
                    if (_isLoading)
                      Center(
                        child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child:
                              CircularProgressIndicator(), //ตัวหมุนๆที่โหลดอ่ะ
                        ),
                      ),
                    HeaderPerMeal(),
                    for (int i = 0; i < 3; i++) buildListMeal(i),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Text('EXIT'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row HeaderPerMeal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Calories per meal',
            style: TextStyle(
              fontSize: 28,
              //backgroundColor: Colors.white.withOpacity(0.4),
              fontFamily: 'ARLRDBD',
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
      ],
    );
  }

  Card buildListMeal(int i) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.restaurant_rounded,
                size: 80,
                color: Colors.indigo.shade600,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    mealName[i],
                    style:
                        TextStyle(fontSize: 24, color: Colors.indigo.shade400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'You can eat : ',
                      style: TextStyle(
                          fontSize: 24, color: Colors.indigo.shade300),
                      children: [
                        TextSpan(
                            text: '${mealCalorie[i].toString()} kcal',
                            style: TextStyle(color: Colors.green))
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding buildBMRorTDEE(String text) {
    var isBMR = text.compareTo('BMR') == 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.lightGreen.shade300,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (isBMR)
                ? Text(
                    'Your BMR : ${bmr.round()} kcal',
                    style: style2,
                  )
                : Text(
                    'Your TDEE : ${tdee.round()} kcal',
                    style: style2,
                  )),
      ),
    );
  }

  Container Header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
      ),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: (isFemale)
                    ? NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnF8pwURYqGpgDnHeFSM_izVcIUfAA3izexnw9fUBtYMkKkrveX3ubIfJrRsST3Ma148E&usqp=CAU")
                    : NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ7XDHaA5U57sw6ED-3ApM22TlSxiSIhyTwj4vXzEJdsGJhYbp-y9cWWMfqbj310H09XQ&usqp=CAU"),
                radius: 80.0,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello ${User.name} ${User.surname}!',
                      style: TextStyle(
                        fontFamily: 'ARLRDBD',
                        fontSize: 30,
                      )),
                  Text(
                      'Weigh : ${User.weigh} kg\nHeight : ${User.height} cm\nAge : ${User.age} years old',
                      style: style1),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _Calculate() async {
    setState(() {
      _isLoading = true;
    });
    if (isFemale) {
      bmr = 665 + (9.6 * User.weigh) + (1.8 * User.height) - (4.7 * User.age);
    } else {
      bmr = 66 + (13.7 * User.weigh) + (5 * User.height) - (6.8 * User.age);
    }
    CalTDEE();
    CalMeal();
    /*  setState(() {
      _isLoading =false;
    });*/
  }

  void CalTDEE() {
    if (User.activity_index == 1)
      tdee = bmr * 1.2;
    else if (User.activity_index == 2)
      tdee = bmr * 1.375;
    else if (User.activity_index == 3)
      tdee = bmr * 1.55;
    else if (User.activity_index == 4)
      tdee = bmr * 1.725;
    else if (User.activity_index == 5) tdee = bmr * 1.9;
  }

  void CalMeal() {
    mealCalorie.add((tdee * 0.4).round());
    mealCalorie.add((tdee * 0.35).round());
    mealCalorie.add((tdee * 0.25).round());
    print(mealCalorie);
    setState(() {
      _isLoading = false;
    });
  }
}
