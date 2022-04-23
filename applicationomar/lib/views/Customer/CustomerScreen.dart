import 'package:applicationomar/SecurityClass.dart';
import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '/widgets/AlertAddNewCustomer.dart';

import '/Api/fetchData.dart';
import '/models/Debts/DebtsModel.dart';
import '/models/Operations/Sell.dart';
import '/views/Customer/DetialsCustomer/detialsCustomer.dart';
import '/views/Customer/DetialsCustomer/profileCustomer.dart';
import 'package:flutter/material.dart';

import '/models/Human/Customer.dart';

// ignore: must_be_immutable
class CustomerScreen extends StatefulWidget {
  @override
  CustomerScreen({
    Key key,
    @required this.customers,
    @required this.debtsCustomer,
  }) : super(key: key);
  _Customerviewstate createState() => _Customerviewstate();
  List<Customer> customers = [];
  List<Debts> debtsCustomer = [];
  Map<String, Debts> tempDebts = {};
  List newCustomer = [null];
  final formkey = GlobalKey<FormState>();
}

class _Customerviewstate extends State<CustomerScreen> {
  TabController controller;

  int selectedIndex = 0;

  List<Widget> list = [
    Tab(child: Text('Debts')),
    Tab(child: Text('Customer')),
  ];

  @override
  void initState() {
    for (Debts debts in widget.debtsCustomer) {
      if (widget.tempDebts[debts.customer.name] == null) {
        widget.tempDebts[debts.customer.name] = debts;
      } else {
        widget.tempDebts[debts.customer.name].value += debts.value;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    print('language code is ' + Security.langaugeCode.toLowerCase());
    widget.newCustomer.addAll(widget.customers);
    for (Debts debts in widget.debtsCustomer) {
      if (widget.tempDebts[debts.customer.name] == null) {
        widget.tempDebts[debts.customer.name] = debts;
      } else {
        widget.tempDebts[debts.customer.name].value += debts.value;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).hintColor == Colors.white
          ? Theme.of(context).backgroundColor
          : Colors.grey[100],
      body: Stack(
        children: [
          //backround all page
          Positioned(
              child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
          )),
          //background top page
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.37,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).hintColor == Colors.white
                      ? Theme.of(context).backgroundColor
                      : Colors.grey,
                  //color: Color(0xFF5094e1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
            ),
          ),
          //customer title page
          Security.langaugeCode == 'en' || Security.langaugeCode == null
              ? Positioned(
                  top: MediaQuery.of(context).size.height * 0.07,
                  left: MediaQuery.of(context).size.width * 0.1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        DemoLocalizations.of(context)
                            .translate('Customer', 'MainPage', key3: 'title'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ))
              : Positioned(
                  top: MediaQuery.of(context).size.height * 0.07,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        DemoLocalizations.of(context)
                            .translate('Customer', 'MainPage', key3: 'title'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
          Security.langaugeCode == 'en' || Security.langaugeCode == null
              ? Positioned(
                  top: MediaQuery.of(context).size.height * 0.055,
                  left: MediaQuery.of(context).size.width * 0.8,
                  child: IconButton(
                      tooltip: DemoLocalizations.of(context).translate(
                          'Customer', 'MainPage', key3: 'FilttedHint'),
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white,
                      )))
              : Positioned(
                  top: MediaQuery.of(context).size.height * 0.055,
                  right: MediaQuery.of(context).size.width * 0.8,
                  child: IconButton(
                      tooltip: DemoLocalizations.of(context).translate(
                          'Customer', 'MainPage',
                          key3: 'FilttedHint'),
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white,
                      ))),
          //all customer text button
          Security.langaugeCode == 'en' || Security.langaugeCode == null
              ? Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetialsCustomer(
                                  customers: widget.customers)));
                    },
                    child: Text(
                      DemoLocalizations.of(context).translate(
                          'Customer', 'MainPage',
                          key3: 'allCustomerButton'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              : Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: MediaQuery.of(context).size.width * 0.65,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetialsCustomer(
                                  customers: widget.customers)));
                    },
                    child: Text(
                      DemoLocalizations.of(context).translate(
                          'Customer', 'MainPage',
                          key3: 'allCustomerButton'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
          //build list view all customer
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.07,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: buildListViewCustomers(context),
            ),
          ),
          //divider line
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              child: Divider(
                height: 12,
                thickness: 3,
                color: Colors.green,
              )),
          //Debts title
          Positioned(
              top: MediaQuery.of(context).size.height * 0.49,
              left: MediaQuery.of(context).size.width * 0.07,
              child: Text(
                DemoLocalizations.of(context)
                    .translate('Customer', 'MainPage', key3: 'debts'),
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              )),
          //build list view debts customer
          Positioned(
              top: MediaQuery.of(context).size.height * 0.55,
              left: MediaQuery.of(context).size.width * 0.01,
              bottom: MediaQuery.of(context).size.height * 0.01,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.99,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.tempDebts.keys.toList().length,
                    itemBuilder: (_, int index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            //here should make list sells for this customer
                            List<Sell> sellsForThisCusotmer =
                                FetchData().sells.where((element) {
                              return element.customer.name ==
                                  widget
                                      .tempDebts[
                                          widget.tempDebts.keys.toList()[index]]
                                      .customer
                                      .name;
                            }).toList();
                            Customer customer = new Customer();
                            for (Customer custmerInArray in widget.customers) {
                              if (custmerInArray.name ==
                                  widget.tempDebts.keys.toList()[index]) {
                                customer = custmerInArray;
                                break;
                              }
                            }

                            try {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileCustomer(
                                          customer: customer,
                                          sellsForThisCustomer:
                                              sellsForThisCusotmer)));
                            } catch (exception) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          content: Text(
                                        exception.toString(),
                                      )));
                            }
                          },
                          trailing: Text(widget
                              .tempDebts[widget.tempDebts.keys.toList()[index]]
                              .value
                              .toString()),
                          title: Text(widget
                              .tempDebts[widget.tempDebts.keys.toList()[index]]
                              .customer
                              .name),
                          leading: Icon(Icons.person),
                        ),
                      );
                    }),
              )),
        ],
      ),
    );
  }

  onTapCell(context, customer) {
    List<Sell> sells = FetchData().sells.where((element) {
      return element.customer.name == customer.name;
    }).toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileCustomer(
                  sellsForThisCustomer: sells,
                  customer: customer,
                )));
  }

  showDialogWarning(String content, context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Icon(
              Icons.warning,
              color: Colors.yellow,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Text(
              DemoLocalizations.of(context).translate(
                  'Customer', 'AllCustomerPage',
                  key3: 'warningDialog', key4: "title"),
            ),
          ],
        ),
        content: Text(
          content +
              DemoLocalizations.of(context).translate(
                  'Customer', 'AllCustomerPage',
                  key3: 'warningDialog', key4: "content"),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              DemoLocalizations.of(context).translate(
                  'Customer', 'AllCustomerPage',
                  key3: 'warningDialog', key4: "cancelButton"),
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              DemoLocalizations.of(context).translate(
                  'Customer', 'AllCustomerPage',
                  key3: 'warningDialog', key4: "addButton"),
            ),
          ),
        ],
      ),
    );
  }

  calledDirectly(number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  paymentTabForCustomer(element, context) {
    TextEditingController paymentAmountController = new TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: EdgeInsets.only(
          top: 8.0,
        ),
        titlePadding: EdgeInsets.only(bottom: 8.0),
        title: Container(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          decoration: BoxDecoration(
            color: Color(0xFF7D7E7E),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
          ),
          child: Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: Text(
              DemoLocalizations.of(context).translate(
                  'Customer', 'AllCustomerPage',
                  key3: 'popupMenuChoices', key4: "payment"),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.0001),
                    child: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.02),
                            child: TextFormField(
                              controller: paymentAmountController,
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                  labelText: DemoLocalizations.of(context)
                                      .translate('Customer', 'AllCustomerPage',
                                          key3: 'dialogPayment', key4: "value"),
                                  labelStyle: TextStyle(fontSize: 18),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (input) => input.trim().isEmpty
                                  ? DemoLocalizations.of(context).translate(
                                      'Customer', 'AllCustomerPage',
                                      key3: 'dialogPayment', key4: "validator1")
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/paymentIconImage.png')),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView buildListViewCustomers(BuildContext context) {
    List<String> popMenu = [
      DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',
          key3: 'popupMenuChoices', key4: "callMobile"),
      DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',
          key3: 'popupMenuChoices', key4: "callPhone"),
      DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',
          key3: 'popupMenuChoices', key4: "detials"),
      DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',
          key3: 'popupMenuChoices', key4: "payment"),
    ];
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.newCustomer.length,
      itemBuilder: (_, int index) {
        if (index == 0) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertAddNewCustomer(widget: widget),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff4c515c)),
                  child: Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              )
            ],
          );
        } else {
          return Row(
            children: [
              GestureDetector(
                onLongPress: () {
                  showMenu(
                    position: RelativeRect.fill,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    items: popMenu.map<PopupMenuItem>((e) {
                      return PopupMenuItem(
                          textStyle:
                              TextStyle(color: Theme.of(context).hintColor),
                          value: e,
                          child: ListTile(
                            onTap: () {
                              e == popMenu[2]
                                  ? onTapCell(
                                      context, widget.newCustomer[index])
                                  : e == popMenu[3]
                                      ? paymentTabForCustomer(
                                          widget.newCustomer[index], context)
                                      : e == popMenu[0]
                                          ? widget.newCustomer[index].mobile !=
                                                  null
                                              ? calledDirectly(widget
                                                  .newCustomer[index].mobile)
                                              : showDialogWarning(
                                                  'mobile', context)
                                          : widget.newCustomer[index].phone !=
                                                  null
                                              ? launchPhoneURL(widget
                                                  .newCustomer[index].phone)
                                              : showDialogWarning(
                                                  'phone', context);
                            },
                            leading: e == popMenu[0]
                                ? Icon(Icons.phone,
                                    color: Theme.of(context).hintColor ==
                                            Colors.white
                                        ? Theme.of(context).hintColor
                                        : Colors.grey)
                                : e == popMenu[1]
                                    ? Icon(Icons.phone_android,
                                        color: Theme.of(context).hintColor ==
                                                Colors.white
                                            ? Colors.white
                                            : Colors.grey)
                                    : e == popMenu[2]
                                        ? Icon(Icons.person,
                                            color:
                                                Theme.of(context).hintColor ==
                                                        Colors.white
                                                    ? Colors.white
                                                    : Colors.grey)
                                        : Icon(
                                            Icons.money_sharp,
                                            color:
                                                Theme.of(context).hintColor ==
                                                        Colors.white
                                                    ? Colors.white
                                                    : Colors.grey,
                                          ),
                            title: Text(
                              e,
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                          ));
                    }).toList(),
                    context: context,
                  );
                },
                onTap: () {
                  List<Sell> sellsForThisCustomer = FetchData()
                      .sells
                      .where((element) =>
                          element.customer.name == widget.customers[index].name)
                      .toList();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileCustomer(
                              customer: widget.newCustomer[index],
                              sellsForThisCustomer: sellsForThisCustomer)));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      CircleAvatar(
                        child: Icon(
                          Icons.person,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        widget.newCustomer[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              )
            ],
          );
        }
      },
    );
  }
}
