import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_saving/screens/earnings_screen.dart';
import 'package:money_saving/services/firebase_query.dart';

addBudgetPopupEarnings(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        double? price;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('PLANOWANY PRZYCHÓD'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              keyboardType: TextInputType.number,
              onChanged: (values) {
                price = double.parse(values);
              },
              decoration: InputDecoration(hintText: 'Kwota'),
              controller: TextEditingController(),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    elevation: 5,
                    child: Text('Dodaj'),
                    onPressed: () {
                      if (price != null) {
                        addEarningBudget(price);
                        // Navigator.pop(context);
                        Navigator.restorablePushNamedAndRemoveUntil(
                            context, EarningsScreen.id, (route) => false);
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        });
      });
}
