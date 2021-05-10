import 'package:flutter/material.dart';
import 'package:money_saving/services/firebase_query.dart';
import 'package:pie_chart/pie_chart.dart';

class PiChartTransaction extends StatefulWidget {
  @override
  _PiChartTransactionState createState() => _PiChartTransactionState();
}

class _PiChartTransactionState extends State<PiChartTransaction> {
  double valueP = 0;
  double valueT = 0;
  double valueD = 0;
  double valueR = 0;
  double valueF = 0;
  _PiChartTransactionState() {
    coutExpenses("PODSTAWOWE").then((value) => setState(() {
          valueP = value;
        }));
    coutExpenses("TRANSPORT").then((value) => setState(() {
          valueT = value;
        }));
    coutExpenses("DOM").then((value) => setState(() {
          valueD = value;
        }));
    coutExpenses("ROZRYWKA").then((value) => setState(() {
          valueR = value;
        }));
    coutExpenses("FINANSE").then((value) => setState(() {
          valueF = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    print(valueP);
    Map<String, double> dataMap = {
      "PODSTAWOWE": valueP,
      "TRANSPORT": valueT,
      "DOM": valueD,
      "ROZRYWKA": valueR,
      "FINANSE": valueF,
    };
    List<Color> colorList = [
      Colors.cyanAccent,
      Colors.orange,
      Colors.red,
      Colors.green,
      Colors.indigoAccent
    ];

    return Container(
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 1500),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 1.9,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.disc,
        ringStrokeWidth: 32,
        centerText: "Wydatki",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 2,
        ),
      ),
    );
  }
}
