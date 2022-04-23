import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '/Api/fetchData.dart';
import '/models/Human/Customer.dart';
import '/models/Operations/Sell.dart';
import '/views/Customer/DetialsCustomer/profileCustomer.dart';

// ignore: must_be_immutable
class DetialsCustomer extends StatelessWidget {
  final List<Customer> customers;

  DetialsCustomer({Key key, @required this.customers}) : super(key: key);
  
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
            Text( DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',key3: 'warningDialog',key4: "title"),),
          ],
        ),
        content: Text(content +
            DemoLocalizations.of(context).translate(
                  'Customer', 'AllCustomerPage',
                  key3: 'warningDialog', key4: "content"), ),
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
                    DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',key3: 'popupMenuChoices',key4: "payment"),
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
                                  labelText:  DemoLocalizations.of(context)
                                      .translate('Customer', 'AllCustomerPage',
                                          key3: 'dialogPayment',
                                          key4: "value"),
                                  labelStyle: TextStyle(fontSize: 18),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (input) => input.trim().isEmpty
                                  ?  DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',key3: 'dialogPayment',key4: "validator1")
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

  buildPopMenuButton(element, context) {
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
    return PopupMenuButton(
      color: Theme.of(context).backgroundColor,
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).hintColor,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      itemBuilder: (context) => popMenu.map((e) {
        return PopupMenuItem(
            textStyle: TextStyle(color: Theme.of(context).hintColor),
            value: e,
            child: ListTile(
              onTap: () {
                e == popMenu[2]
                    ? onTapCell(context, element)
                    : e == popMenu[3]
                        ? paymentTabForCustomer(element, context)
                        : e == popMenu[0]
                            ? element.mobile != null
                                ? calledDirectly(element.mobile)
                                : showDialogWarning('mobile', context)
                            : element.phone != null
                                ? launchPhoneURL(element.phone)
                                : showDialogWarning('phone', context);
              },
              leading: e == popMenu[0]
                  ? Icon(Icons.phone,
                      color: Theme.of(context).hintColor == Colors.white
                          ? Theme.of(context).hintColor
                          : Colors.grey)
                  : e == popMenu[1]
                      ? Icon(Icons.phone_android,
                          color: Theme.of(context).hintColor == Colors.white
                              ? Colors.white
                              : Colors.grey)
                      : e == popMenu[2]
                          ? Icon(Icons.person,
                              color: Theme.of(context).hintColor == Colors.white
                                  ? Colors.white
                                  : Colors.grey)
                          : Icon(
                              Icons.money_sharp,
                              color: Theme.of(context).hintColor == Colors.white
                                  ? Colors.white
                                  : Colors.grey,
                            ),
              title: Text(
                e,
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ));
      }).toList(),
    );
  }

  buildColumns(context) {
    final style = TextStyle(
        color: Theme.of(context).hintColor,
        fontSize: 15,
        fontWeight: FontWeight.w600);
    return <DataColumn>[
      DataColumn(
        label: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).hintColor,
          ),
        ),
        tooltip: DemoLocalizations.of(context)
            .translate('Customer', 'AllCustomerPage', key3: 'moreVert'),
      ),
      DataColumn(
        label: Text(
          DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',key3: 'id')
          ,
          style: style,
        ),
        tooltip: DemoLocalizations.of(context)
            .translate('Customer', 'AllCustomerPage', key3: 'id'),
      ),
      DataColumn(
        label: Text(
          DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',key3: 'name'),
          style: style,
        ),
        tooltip:       DemoLocalizations.of(context)
            .translate('Customer', 'AllCustomerPage', key3: 'name'),
      ),
      DataColumn(
        numeric: true,
        label: Text(
          DemoLocalizations.of(context)
              .translate('Customer', 'AllCustomerPage', key3: 'remaning'),
          style: style,
        ),
        tooltip: DemoLocalizations.of(context)
            .translate('Customer', 'AllCustomerPage', key3: 'remaning'),
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            customers.sort((item1, item2) =>
                item1.remainingAmount.compareTo(item2.remainingAmount));
          } else {
            customers.sort((item1, item2) =>
                item2.remainingAmount.compareTo(item1.remainingAmount));
          }
        },
      ),
      DataColumn(
        numeric: true,
        label: Text(
          DemoLocalizations.of(context)
              .translate('Customer', 'AllCustomerPage', key3: 'Amount'),
          style: style,
        ),
        tooltip: DemoLocalizations.of(context)
            .translate('Customer', 'AllCustomerPage', key3: 'Amount'),
      ),
    ];
  }

  buildRows(context) {
    List<DataRow> rows = [];
    for (int i = 0; i < customers.length; i++) {
      rows.add(
        DataRow(
          cells: buildCells(customers[i], context),
        ),
      );
    }
    return rows;
  }

  buildCells(Customer element, context) {
    return <DataCell>[
      DataCell(
        buildPopMenuButton(element, context),
      ),
      DataCell(
        Text(
          element.id,
          style: TextStyle(
            color: Theme.of(context).hintColor,
          ),
        ),
        placeholder: true,
        // onDoubleTap: onTapCell(context),
      ),
      DataCell(
        Text(
          element.name,
          style: TextStyle(
            color: Theme.of(context).hintColor,
          ),
          textDirection: TextDirection.ltr,
        ),
        //style:TextStyle(color:Theme.of(context).hintColor,), onDoubleTa
        //p: onTapCell(context)),
      ),
      DataCell(
        Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              element.amountPaid.toString(),
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
        ),
        // onDoubleTap: onTapCell(context),
      ),
      DataCell(
        Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.00),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              element.remainingAmount.toString(),
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
        ),
        // onDoubleTap: onTapCell(context),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).translate('Customer', 'AllCustomerPage',key3:"appBarTitle")),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.00),
            child: DataTable(
              
              horizontalMargin: 4,
              columns: buildColumns(context),
              rows: buildRows(context),
            ),
          ),
        ),
      ),
    );
  }
}
