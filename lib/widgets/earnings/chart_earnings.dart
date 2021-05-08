import 'package:flutter/material.dart';
import 'package:money_saving/services/firebase_query.dart';
import 'package:pie_chart/pie_chart.dart';

class PiChartTransactionEarnings extends StatefulWidget {
  @override
  _PiChartTransactionEarningsState createState() =>
      _PiChartTransactionEarningsState();
}

class _PiChartTransactionEarningsState
    extends State<PiChartTransactionEarnings> {
  double valueP = 0;
  double valueD = 0;
  double valueI = 0;

  _PiChartTransactionEarningsState() {
    coutEarnings("PENSJA").then((value) => setState(() {
          valueP = value;
        }));
    coutEarnings("DODATKI").then((value) => setState(() {
          valueD = value;
        }));
    coutEarnings("INNE").then((value) => setState(() {
          valueI = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    print(valueP);
    Map<String, double> dataMap = {
      "PENSJA": valueP,
      "DODATKI": valueD,
      "INNE": valueI,
    };
    List<Color> colorList = [
      Colors.green,
      Colors.orange,
      Colors.red,
    ];

    return Container(
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 1500),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 1.8,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.disc,
        ringStrokeWidth: 32,
        centerText: "PRZYCHODY",
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
