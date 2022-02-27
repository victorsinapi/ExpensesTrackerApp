import 'package:flutter/material.dart';
import 'package:flutter_02_expance/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amount = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day)
          amount += recentTransactions[i].amount;
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': amount
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map((data) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(totalSpending == 0.0 ? 0.0 : data['day'],
                        data['amount'], data['amount'] / totalSpending),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
