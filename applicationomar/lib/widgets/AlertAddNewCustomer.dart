import 'package:applicationomar/views/Customer/CustomerScreen.dart';
import 'package:flutter/material.dart';

class AlertAddNewCustomer extends StatelessWidget {
  const AlertAddNewCustomer({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final CustomerScreen widget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      contentPadding: EdgeInsets.only(
        top: 8.0,
      ),
      titlePadding: EdgeInsets.only(bottom: 8.0),
      title: Container(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        child: Center(
            child: Text(
          'Add new Customer',
          style: TextStyle(color: Colors.white),
        )),
      ),
      content: Container(
        child: Form(
          key: widget.formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name Customer',
                      label: Text('Name Customer'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Phone Customer',
                      label: Text('Phone Customer'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Address Customer',
                      label: Text('Address Customer'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'mobile Customer',
                      label: Text('mobile Customer'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.35),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
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
}
