import 'package:flutter/material.dart';
import 'package:money_saving/services/firebase_query.dart';
import 'package:money_saving/widgets/expenses/budget_popup.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgresBar extends StatefulWidget {
  late double width;
  bool expenses = true; //Wybór czy wydatek czy wpłata
  ProgresBar(double this.width, bool this.expenses);
  @override
  _ProgresBarState createState() => _ProgresBarState();
}

class _ProgresBarState extends State<ProgresBar> {
  double allExpenses = 1.0;
  double budgetSize = 1.0;
  double procent = 0.0;
  _ProgresBarState() {
    coutAllExpenses().then((value) => setState(() {
          allExpenses = value;
        }));
    getExpensesBudget().then((value) => setState(() {
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
        addBudgetPopup(context);
      },
      child: Column(
        children: [
          Text(
            'BUDŻET',
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
              percent: (allExpenses / budgetSize) > 1
                  ? 1.0
                  : (allExpenses / budgetSize), //Nie większe niż 1
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
              animation: true,
              animationDuration: 1200,
              center: Text(
                '$allExpenses / $budgetSize',
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



// Progress Bar jako funkcja, może się jeszcze przydać 

// Widget progressBar(double width) {
//   return InkWell(
//     onDoubleTap: () {
//       print('doubleTab');
//     },
//     child: LinearPercentIndicator(
//       width: width,
//       lineHeight: 30.0,
//       percent: 0.4,
//       backgroundColor: Colors.grey,
//       progressColor: Colors.blue,
//       animation: true,
//       animationDuration: 1200,
//       center: Text(
//         '40%',
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//           fontSize: 20.0,
//         ),
//       ),
//     ),
//   );
// }