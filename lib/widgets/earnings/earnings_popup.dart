import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_saving/screens/earnings_screen.dart';
import 'package:money_saving/services/firebase_query.dart';

addEarningsPopup(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        String category = 'PENSJA';
        String? name;
        double? price;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Nazwa przychodu'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: TextField(
              onChanged: (values) {
                name = values;
              },
              decoration: InputDecoration(hintText: 'Tytuł przychodu'),
              controller: TextEditingController(),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.attach_money),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (values) {
                          price = double.parse(values);
                        },
                        decoration: InputDecoration(
                          hintText: 'Kwota',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: DropdownButton<String>(
                      value: category,
                      underline: Container(
                        height: 2,
                        color: Color(0xffFC9472),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                      items: <String>[
                        'PENSJA',
                        'DODATKI',
                        'INNE',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    elevation: 5,
                    child: Text('Dodaj'),
                    onPressed: () {
                      if (name != null && price != null) {
                        addEarning(category, name, price);
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
