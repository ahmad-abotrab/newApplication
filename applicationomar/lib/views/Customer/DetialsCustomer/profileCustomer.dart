import 'package:applicationomar/localization/localizationFile.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Api/PdfApi.dart';
import '/Api/PdfBillApi.dart';
import '/assets.dart';
import '/models/Human/Customer.dart';
import '/models/Operations/Sell.dart';

import 'AmountPaidDetails.dart';

// ignore: must_be_immutable
class ProfileCustomer extends StatelessWidget {
  ProfileCustomer(
      {Key key, @required this.customer, @required this.sellsForThisCustomer})
      : super(key: key);
  Customer customer;
  List<Sell> sellsForThisCustomer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          //here is background page
          Positioned(
              child: Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          )),

          //here is body of page is white boarder
          Positioned(
              top: MediaQuery.of(context).size.height * 0.32,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Theme.of(context).backgroundColor,
                ),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.32,
                width: MediaQuery.of(context).size.width,
              )),

          //image customer widget
          Positioned(
            top: MediaQuery.of(context).size.height * 0.07,
            left: MediaQuery.of(context).size.width * 0.1,
            child: imageCustomer(),
          ),

          //customer name widget
          Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              left: MediaQuery.of(context).size.width * 0.06,
              child: Text(
                customer.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )),

          //this three widget to show (Amount paid - remaining paid -total amount ) for a specific customer
          Positioned(
            top: MediaQuery.of(context).size.height * 0.07,
            left: MediaQuery.of(context).size.width * 0.35,
            child: detialsMoneyForCustomer(
              context,
             DemoLocalizations.of(context).translate('Customer', 'ProfileCustomer',key3:'AmountPaid'),
              Icons.trending_up_outlined,
              customer.amountPaid.toString(),
              pressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AmountPaidDetials(customer: customer)));
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.14,
            left: MediaQuery.of(context).size.width * 0.35,
            child: detialsMoneyForCustomer(
                context,
                DemoLocalizations.of(context).translate(
                    'Customer', 'ProfileCustomer',
                    key3: 'Remainig'),
                Icons.trending_down_outlined,
                customer.remainingAmount.toString(),
                //pressed is optional you can added or not
                pressed: () {}),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            left: MediaQuery.of(context).size.width * 0.35,
            child: detialsMoneyForCustomer(
                context,
                DemoLocalizations.of(context).translate(
                    'Customer', 'ProfileCustomer', key3: 'total'),
                Icons.money_rounded,
                customer.totalAmount.toString() == 'null'
                    ? (customer.remainingAmount + customer.amountPaid)
                        .toString()
                    : customer.totalAmount.toString(),
                pressed: () {}),
          ),
          //_________________End amount information____________________

          //this widget is title for list view (id - non - value)
          Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                          DemoLocalizations.of(context).translate(
                              'Customer', 'ProfileCustomer',
                              key3: 'id'),
                          style: TextStyle(color: Theme.of(context).hintColor)),
                      title: Text(
                          DemoLocalizations.of(context).translate(
                              'Customer', 'ProfileCustomer',
                              key3: 'date'),
                          style: TextStyle(color: Theme.of(context).hintColor)),
                      trailing: Text(
                          DemoLocalizations.of(context).translate(
                              'Customer', 'ProfileCustomer',
                              key3: 'value'),
                          style: TextStyle(color: Theme.of(context).hintColor)),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 10,
                    ),
                  ],
                ),
              )),

          //this widget To view the invoices of a specific customer , and can when tab on list title open pdf invoice
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            child: SingleChildScrollView(
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).backgroundColor),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.45,
                child: listViewBillForCustomer(context),
              ),
            ),
          ),
        ],
      ),
    ));
  }

//this is list view bill
  ListView listViewBillForCustomer(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm');
    return ListView.builder(
        itemCount: sellsForThisCustomer.length,
        itemBuilder: (_, int index) {
          return ListTile(
            onTap: () {
              tapToOpenPdfBill(sellsForThisCustomer[index], context);
            },
            leading: Text(
              sellsForThisCustomer[index].id,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            title: Text(
              sellsForThisCustomer[index].date == null
                  ? '0'
                  : dateFormat.format(sellsForThisCustomer[index].date),
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            trailing: Text(
              sellsForThisCustomer[index].value.toString(),
              style: TextStyle(
                color: Theme.of(context).hintColor == Colors.white
                    ? Colors.white
                    : Colors.green[300],
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        });
  }

// this widget to open pdf file helped by classes (pdfBillApi and pdfApi)
  Future<dynamic> tapToOpenPdfBill(bill, context) async {
    final file = await PdfBilleApi.generate(
        bill, MediaQuery.of(context).size.width * 0.9);
    PdfApi.openFile(file);
  }

//this widget is row have (title - icon - value )
  Widget detialsMoneyForCustomer(
      BuildContext context, title, iconsData, content,
      {pressed}) {
    return MaterialButton(
      onPressed: pressed,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Icon(iconsData, color: Colors.white),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

//this is widget to show image customer if there
  AvatarGlow imageCustomer() {
    return AvatarGlow(
      endRadius: 30,
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      glowColor: Colors.blue,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person_outline_rounded,
          size: 50,
        ),
      ),
    );
  }
}
