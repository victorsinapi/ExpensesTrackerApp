import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;

  void _addTransaction() {
    if (_priceController.text.isEmpty) {
      return;
    }
    final title = _titleController.text;
    final price = double.parse(_priceController.text);

    if (title.isEmpty || price <= 0 || _selectedDate == null) return;

    widget.addTx(_titleController.text, double.parse(_priceController.text),
        _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((date) => {
              if (date != null)
                setState(() {
                  _selectedDate = date;
                })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Titolo'),
                // onChanged: (val) => titleInput = val,
                controller: _titleController,
                onSubmitted: (_) => _addTransaction,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Prezzo'),
                // onChanged: (val) => amountInput = val,
                controller: _priceController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addTransaction,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : DateFormat.yMd().format(_selectedDate!)),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Chose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _addTransaction,
                child: Text('Add Transaction'),
              )
            ],
          ),
        ));
  }
}
