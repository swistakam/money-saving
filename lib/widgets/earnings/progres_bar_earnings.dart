import 'package:flutter/material.dart';
import 'package:money_saving/services/firebase_query.dart';
import 'package:money_saving/widgets/earnings/budget_popup_earnings.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgresBarEarnings extends StatefulWidget {
  late double width;
  bool expenses = true; //Wybór czy wydatek czy wpłata
  ProgresBarEarnings(double this.width, bool this.expenses);
  @override
  _ProgresBarEarningsState createState() => _ProgresBarEarningsState();
}

class _ProgresBarEarningsState extends State<ProgresBarEarnings> {
  double allEarnings = 1.0;
  double budgetSize = 1.0;
  double procent = 0.0;
  _ProgresBarEarningsState() {
    coutAllEarnings().then((value) => setState(() {
          allEarnings = value;
        }));
    getEarningsBudget().then((value) => setState(() {
          budgetSize = value;
        }));
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Text(
              'Przytrzymaj aby zmienić',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ),
        );
      },
      onLongPress: () {
        addBudgetPopupEarnings(context);
      },
      child: Column(
        children: [
          Text(
            'PLANOWANY PRZYCHÓD',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Container(
            child: LinearPercentIndicator(
              width: widget.width,
              lineHeight: 30.0,
              percent: (allEarnings / budgetSize) > 1
                  ? 1.0
                  : (allEarnings / budgetSize), //Nie większe niż 1
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
              animation: true,
              animationDuration: 1200,
              center: Text(
                '$allEarnings / $budgetSize',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// // Progress Bar jako funkcja, może się jeszcze przydać 

// // Widget progressBar(double width) {
// //   return InkWell(
// //     onDoubleTap: () {
// //       print('doubleTab');
// //     },
// //     child: LinearPercentIndicator(
// //       width: width,
// //       lineHeight: 30.0,
// //       percent: 0.4,
// //       backgroundColor: Colors.grey,
// //       progressColor: Colors.blue,
// //       animation: true,
// //       animationDuration: 1200,
// //       center: Text(
// //         '40%',
// //         style: TextStyle(
// //           color: Colors.black,
// //           fontWeight: FontWeight.bold,
// //           fontSize: 20.0,
// //         ),
// //       ),
// //     ),
// //   );
// // }