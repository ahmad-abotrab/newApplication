import 'dart:convert';

import 'package:applicationomar/Api/Controller/HomeController.dart';
import 'package:applicationomar/localization/localizationFile.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '/views/Nav_Bar_Pages/Home_screen.dart';
import '/views/Nav_Bar_Pages/Logs_Screen.dart';
import '/views/Nav_Bar_Pages/Warehouse_screen.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '/Api/fetchData.dart';

import '/models/Human/Customer.dart';
import '/models/Human/Employee.dart';
import '/views/Customer/CustomerScreen.dart';

import '/views/Operations_pages/Menu.dart';

import '/localization/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'DrawarWidget.dart';
import 'Language.dart';

class BottomNav extends StatefulWidget {
  BottomNav({
    this.customers,
    this.employee,
    Key key,
  }) : super(key: key);
  @override
  _BottomNavState createState() => _BottomNavState();

  List<Customer> customers;
  List<Employee> employees = [];
  Customer customer = new Customer();
  Employee employee;
}

class _BottomNavState extends State<BottomNav> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  pppp() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(shared_User.getString('user'));
    var user = Employee.fromJson(userMap);
    print(user.name);
  }

  List<Widget> children = [];
  @override
  void initState() {
    pppp();
    
    children = [
      Homescreen(),
      LogsScreen(),
      MenuPage(),
      WareHouse(),
      CustomerScreen(
          customers: widget.customers == null
              ? FetchData().getCustomerlist()
              : widget.customers.isEmpty
                  ? FetchData().getCustomerlist()
                  : widget.customers)
    ];
    super.initState();
  }

  @override
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.employees.add(
      Employee(id: '1', name: 'Ahmad', pin: '5555', career: 'مدير'),
    );
    widget.employees.add(
      Employee(id: '2', name: 'Fadi', pin: '9999', career: 'محاسب'),
    );
    widget.employees.add(
      Employee(id: '3', name: 'Omar', pin: '4567', career: "Manager"),
    );
    widget.employees.add(
      Employee(id: '4', name: 'Milad', pin: '1478', career: 'موظف'),
    );
    void choiceLanguage(Language language) {
      Locale locale;

      switch (language.languageCode) {
        case 'en':
          {
            locale = new Locale(language.languageCode, 'US');

            break;
          }
        case 'ar':
          {
            locale = new Locale(language.languageCode, 'SY');

            break;
          }
        default:
          {
            locale = new Locale(language.languageCode, 'SY');
            break;
          }
      }

      MyApp.setLocale(context, locale);
    }

    children = [
      Homescreen(),
      LogsScreen(),
      MenuPage(),
      WareHouse(),
      CustomerScreen(
          debtsCustomer: FetchData.deptsProducts,
          customers: widget.customers == null
              ? FetchData().getCustomerlist()
              : widget.customers.isEmpty
                  ? FetchData().getCustomerlist()
                  : widget.customers),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBody: true,
      appBar: currentIndex != 4
          ? AppBar(
              // backgroundColor: Colors.grey,
              centerTitle: true,
              title: Text(DemoLocalizations.of(context)
                  .translate('Home', 'title_text')),
              actions: [
                  GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (_) {
                      return PopupMenuButton<Language>(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        elevation: 5,
                        tooltip: DemoLocalizations.of(context)
                            .translate("LoginPage", "selectLang"),
                        icon: Icon(Icons.language, color: Colors.white),
                        onSelected: (value) {
                          choiceLanguage(value);
                        },
                        itemBuilder: (context) => Language.langList(context)
                            .map<PopupMenuItem<Language>>((e) {
                          return PopupMenuItem<Language>(
                              value: e,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.flag),
                                  Text(
                                    e.name,
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                ],
                              ));
                        }).toList(),
                      );
                    },
                  )
                ])
          : null,
      drawer: DrawerWidget(
        cardA: cardA,
        // employee: widget.employee,
      ),
      body: children[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
          child: BottomNavigationBar(
            onTap: onTabTapped,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.teal,
            selectedLabelStyle: TextStyle(fontSize: 10),
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                tooltip: DemoLocalizations.of(context)
                    .translate('NavBar', 'home_text'),
                icon: Icon(Icons.home, size: 30),
                label: DemoLocalizations.of(context)
                    .translate('NavBar', 'home_text'),
                activeIcon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book, size: 30),
                label: DemoLocalizations.of(context)
                    .translate('NavBar', 'logs_text'),
                tooltip: DemoLocalizations.of(context)
                    .translate('NavBar', 'logs_text'),
                activeIcon: Icon(
                  Icons.menu_book,
                  size: 30,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calculate_rounded,
                  size: 30,
                ),
                activeIcon: Icon(
                  Icons.calculate_outlined,
                  size: 30,
                ),
                tooltip: DemoLocalizations.of(context)
                    .translate('NavBar', 'Operations_text'),
                label: DemoLocalizations.of(context)
                    .translate('NavBar', 'Operations_text'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.local_shipping,
                  size: 30,
                ),
                activeIcon: Icon(
                  Icons.local_shipping_outlined,
                  size: 30,
                ),
                label: DemoLocalizations.of(context)
                    .translate('NavBar', 'warehouse_text'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: DemoLocalizations.of(context)
                    .translate('NavBar', 'customer_text'),
                activeIcon: Icon(
                  Icons.person_outline_outlined,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
