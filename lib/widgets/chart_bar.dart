import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.percentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(250, 250, 250, 1),
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(20)),
              ),
              FractionallySizedBox(
                  heightFactor: percentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ))
            ],
          ),
        ),
        Text(label)
      ],
    );
  }
}
