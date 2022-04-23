// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/Human/Customer.dart';

// ignore: must_be_immutable
class AmountPaidDetials extends StatelessWidget {
  AmountPaidDetials({
    Key key,
    @required this.customer,
  }) : super(key: key);
  Customer customer;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm');

  buildColumn(context) {
    return <DataColumn>[
      DataColumn(
          label:
              Text('id', style: TextStyle(color: Theme.of(context).hintColor))),
      DataColumn(
          label: Text('Data Of Paid',
              style: TextStyle(color: Theme.of(context).hintColor))),
      DataColumn(
          label: Text('Payment value',
              style: TextStyle(color: Theme.of(context).hintColor))),
    ];
  }

  buildRows(context) {
    return <DataRow>[
      DataRow(cells: buildCells(context)),
    ];
  }

  buildCells(context) {
    return <DataCell>[
      DataCell(Text('1', style: TextStyle(color: Theme.of(context).hintColor))),
      DataCell(Text(dateFormat.format(DateTime.now()),
          style: TextStyle(color: Theme.of(context).hintColor))),
      DataCell(Text('1', style: TextStyle(color: Theme.of(context).hintColor))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Amount Paid Detials',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: buildColumn(context),
            rows: buildRows(context),
          ),
        ),
      ),
    );
  }
}
