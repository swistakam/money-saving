import 'package:flutter/material.dart';

const kTextInputDecoration = InputDecoration(
  hintText: 'Enter the value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

var kColorExpenses = Color(0xffFC9472);
var kColorEarnings = Color(0xff80CA9F);

//Dobra koloru na podstawie kategorii Wydatku
Color colorSelect(String category) {
  if (category == 'PODSTAWOWE') {
    return Colors.cyanAccent;
  } else if (category == 'TRANSPORT') {
    return Colors.orange;
  } else if (category == 'DOM') {
    return Colors.red;
  } else if (category == 'ROZRYWKA') {
    return Colors.green;
  } else if (category == 'FINANSE') {
    return Colors.indigoAccent;
  } else {
    return Colors.black;
  }
}

//Dobranie ikonki na podstawie kategorii Wydatku
IconData iconSelect(String category) {
  if (category == 'PODSTAWOWE') {
    return Icons.fastfood;
  } else if (category == 'TRANSPORT') {
    return Icons.car_repair;
  } else if (category == 'DOM') {
    return Icons.home;
  } else if (category == 'ROZRYWKA') {
    return Icons.tv;
  } else if (category == 'FINANSE') {
    return Icons.money_off;
  } else {
    return Icons.money_off;
  }
}

//Dobra koloru na podstawie kategorii Wpłaty
Color colorSelectEarnings(String category) {
  if (category == 'PENSJA') {
    return Colors.green;
  } else if (category == 'DODATKI') {
    return Colors.orange;
  } else if (category == 'INNE') {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

//Dobranie ikonki na podstawie kategorii Wpłaty
IconData iconSelectEarnings(String category) {
  if (category == 'PENSJA') {
    return Icons.attach_money;
  } else if (category == 'DODATKI') {
    return Icons.money;
  } else if (category == 'INNE') {
    return Icons.business_center_rounded;
  } else {
    return Icons.money_off;
  }
}
