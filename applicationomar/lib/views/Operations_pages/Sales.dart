import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';

import '/views/Operations_pages/Income.dart';
import '/views/Operations_pages/SellProduct.dart';
import '/widgets/OperationUnit.dart';

class SalesMenu extends StatefulWidget {
  @override
  _SalesMenuState createState() => _SalesMenuState();
}

class _SalesMenuState extends State<SalesMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.07),
        child: Column(
          children: [
            OperationUnit(
              nameOperation:  DemoLocalizations.of(context)
            .translate('Operations', 'Sales', key3: 'Sell_text'),
              onTapPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SallingProducts()));
              },
              colorDecorationParentContainer: Colors.blue[300],
              iconOperation: Icons.store_mall_directory,
              backgroundIconColor: Colors.blue[200],
              explainAboutOperation:
                  DemoLocalizations.of(context)
            .translate('Operations', 'Sales', key3: 'Selling_Products_desc'),
            ),
            OperationUnit(
              nameOperation:  DemoLocalizations.of(context)
            .translate('Operations', 'Sales', key3: 'Income_text'),
              onTapPressed: () {
                showDialog(context: context, builder: (context) => InComming());
              },
              colorDecorationParentContainer: Colors.teal[200],
              iconOperation: Icons.input,
              backgroundIconColor: Colors.teal[100],
              explainAboutOperation:
                 DemoLocalizations.of(context)
            .translate('Operations', 'Sales', key3: 'Income_desc'),
            ),
          ],
        ),
      ),
    );
  }
}
