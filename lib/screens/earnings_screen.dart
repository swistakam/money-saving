import 'package:flutter/material.dart';
import 'package:money_saving/services/firebase_query.dart';
import 'package:money_saving/themes/constans.dart';
import 'package:money_saving/widgets/earnings/chart_earnings.dart';
import 'package:money_saving/widgets/earnings/earnings_popup.dart';
import 'package:money_saving/widgets/earnings/progres_bar_earnings.dart';
import 'package:money_saving/widgets/earnings/transaction_space_earnings.dart';
import 'package:money_saving/widgets/expenses/progres_bar_expenses.dart';

class EarningsScreen extends StatefulWidget {
  static const id = 'EarningsScreen';

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  @override
  Widget build(BuildContext context) {
    final meadiaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEarningsPopup(context);
        },
        child: Icon(
          Icons.add_circle_rounded,
          color: Colors.white,
          size: 50,
        ),
        backgroundColor: kColorEarnings,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              color: kColorEarnings,
              onPressed: () {
                signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout_sharp),
            ),
            Text(
              'Przychody',
              style: TextStyle(
                color: kColorEarnings,
              ),
            ),
            IconButton(
              color: kColorEarnings,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.attach_money,
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
                  PiChartTransactionEarnings(),
                  ProgresBarEarnings(meadiaQuery.size.width * 0.9, false),
                ],
              ),
            ],
          ),
          TransactionSpaceEarnings(0.55),
        ],
      ),
    );
  }
}
