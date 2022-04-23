import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import '/widgets/OperationUnit.dart';
import '/views/Operations_pages/returns.dart';
import 'package:vector_math/vector_math.dart' as math;
import '/views/Operations_pages/Bills.dart';
import '/views/Operations_pages/Costs.dart';
import '/views/Operations_pages/Recipes.dart';
import 'package:easy_localization/easy_localization.dart';
import '/views/Operations_pages/Salaries.dart';
import '/views/Operations_pages/Withdrawal.dart';
import '/localization/local_keys.g.dart';

class PaymentMenu extends StatefulWidget {
  @override
  _PaymentMenuState createState() => _PaymentMenuState();
}

class _PaymentMenuState extends State<PaymentMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.0),
        child: Column(
          children: [
            //salary
            OperationUnit(
              nameOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Salaries'),
              onTapPressed: () {
                showDialog(context: context, builder: (context) => Salaries());
              },
              colorDecorationParentContainer: Colors.blueGrey[200],
              iconOperation: Icons.payments,
              backgroundIconColor: Colors.blueGrey[100],
              explainAboutOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Salaries'),
            ),

            //refille
            OperationUnit(
              nameOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Recipes'),
              onTapPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RefillScreen()));
              },
              colorDecorationParentContainer: Colors.indigo[300],
              iconOperation: Icons.receipt,
              backgroundIconColor: Colors.indigo[200],
              explainAboutOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Recipes'),
            ),

            //bills
            OperationUnit(
              nameOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Bills'),
              onTapPressed: () {
                showDialog(context: context, builder: (context) => Bills());
              },
              colorDecorationParentContainer: Colors.blue[200],
              iconOperation: Icons.bolt,
              backgroundIconColor: Colors.blue[100],
              explainAboutOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Bills'),
            ),

            //cost
            OperationUnit(
              nameOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Costs'),
              onTapPressed: () {
                showDialog(
                    context: context, builder: (context) => CostsScreen());
              },
              colorDecorationParentContainer: Colors.green[300],
              iconOperation: Icons.monetization_on_outlined,
              backgroundIconColor: Colors.green[200],
              explainAboutOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Costs'),
            ),

            //withdrawal
            OperationUnit(
              nameOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Withdrawal'),
              onTapPressed: () {
                showDialog(
                    context: context, builder: (context) => Withdrawal());
              },
              colorDecorationParentContainer: Colors.red[200],
              iconOperation: Icons.payments,
              backgroundIconColor: Colors.red[100],
              explainAboutOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Withdrawal'),
            ),

            OperationUnit(
              nameOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Returns'),
              onTapPressed: () {
                showDialog(context: context, builder: (context) => Returns());
              },
              colorDecorationParentContainer: Colors.teal[200],
              iconOperation: Icons.payments,
              backgroundIconColor: Colors.teal[100],
              explainAboutOperation: DemoLocalizations.of(context)
                  .translate('Operations', 'Payments', key3: 'Returns'),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            )
          ],
        ),
      ),
    );
  }
}
