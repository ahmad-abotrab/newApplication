import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import '/views/Operations_pages/Payments.dart';
import '/views/Operations_pages/Sales.dart';

// ignore: must_be_immutable
class MenuPage extends StatefulWidget {
  String languageCode;
  MenuPage({Key key, this.languageCode}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  @override
  TabController _controller;
  int _selectedIndex = 0;

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length:2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              unselectedLabelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              controller: _controller,
              // automaticIndicatorColorAdjustment: true,
              indicatorColor: Colors.grey,
              indicatorWeight: 5,
              tabs: [
                  Tab(
                  text: DemoLocalizations.of(context).translate('Operations', 'Sales',key3:'Sales_text'),
                ),
                Tab(
                  text:  DemoLocalizations.of(context)
                      .translate('Operations', 'Payments', key3: 'payments_text'),
                ),
              ],
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          SalesMenu(),
          PaymentMenu(),
        ],
      ),
    );
  }
}
