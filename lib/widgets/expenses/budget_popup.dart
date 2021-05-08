import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_saving/screens/expenses_screen.dart';
import 'package:money_saving/services/firebase_query.dart';

addBudgetPopup(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        double? price;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('BUDŻET'),
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
              decoration: InputDecoration(hintText: 'Kwota do wydania'),
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
                        addExpenseBudget(price);
                        // Navigator.pop(context);
                        Navigator.restorablePushNamedAndRemoveUntil(
                            context, ExpenseScreen.id, (route) => false);
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
