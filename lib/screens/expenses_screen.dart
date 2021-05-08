import 'package:flutter/material.dart';
import 'package:money_saving/screens/earnings_screen.dart';
import 'package:money_saving/services/firebase_query.dart';
import 'package:money_saving/themes/constans.dart';
import 'package:money_saving/widgets/expenses/chart_expenses.dart';
import 'package:money_saving/widgets/expenses/expenses_popup.dart';
import '../widgets/expenses/transaction_space_expenses.dart';
import 'package:money_saving/widgets/expenses/progres_bar_expenses.dart';

class ExpenseScreen extends StatefulWidget {
  static const id = 'expense_screen';

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    final meadiaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addExpensesPopup(context);
        },
        child: Icon(
          Icons.add_circle_rounded,
          color: Colors.white,
          size: 50,
        ),
        backgroundColor: kColorExpenses,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              color: kColorExpenses,
              onPressed: () {
                signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout_sharp),
            ),
            Text(
              'Wydatki',
              style: TextStyle(
                color: kColorExpenses,
              ),
            ),
            IconButton(
              color: kColorExpenses,
              onPressed: () {
                Navigator.pushNamed(context, EarningsScreen.id);
              },
              icon: Icon(
                Icons.money_off,
                color: kColorExpenses,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PiChartTransaction(),
                  ProgresBar(meadiaQuery.size.width * 0.9, true),
                ],
              ),
            ],
          ),
          TransactionSpaceExpenses(0.55),
        ],
      ),
    );
  }
}
