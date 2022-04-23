import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '/models/Human/Employee.dart';

// ignore: must_be_immutable
class CompletelyRegister extends StatefulWidget {
  CompletelyRegister({Key key, this.employee, this.userEmployee})
      : super(key: key);
  Employee employee;
  final formKey = GlobalKey<FormState>();
  bool show = true;
  TextEditingController email, password;

  Employee userEmployee;

  Map<String, dynamic> checked = {
    "createAccount": false,
    "finincalReports": false,
    "deleteAccount": false,
    "searchEmployee": false,
    "available": false,
  };

  @override
  _CompletelyRegisterState createState() => _CompletelyRegisterState();
}

class _CompletelyRegisterState extends State<CompletelyRegister> {
  
  @override
  void initState() {
    widget.email = TextEditingController();
    widget.password = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildHeadOfPage('Available powers for this employee?'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                TextFormField(
                  controller: widget.email,
                  validator: (value) =>
                      value.isNotEmpty ? null : "Please Enter a email address",
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText:
                        'email',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  controller: widget.password,
                  keyboardType: TextInputType.number,
                  validator: (value) => value.length < 6
                      ? "less than 6 character should be more than 8"
                      : null,
                  obscureText: widget.show,
                  decoration: InputDecoration(
                    hintText: 'password',
                    prefixIcon: IconButton(
                      icon: widget.show
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          widget.show = !widget.show;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('صلاحيات الموظف الجديد'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["createAccount"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["createAccount"] = value;
                          });
                        }),
                    Text('create account')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["finincalReports"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["finincalReports"] = value;
                          });
                        }),
                    Text('رؤية التقارير المالية')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["deleteAccount"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["deleteAccount"] = value;
                          });
                        }),
                    Text('حذف حساب موظف')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["searchEmployee"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["searchEmployee"] = value;
                          });
                        }),
                    Text('البحث عن موظف')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["available"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["available"] = value;
                          });
                        }),
                    Text('تعديل على الصلاحيات')
                  ],
                ),
                MaterialButton(
                  onPressed: () async {
                    if (widget.formKey.currentState.validate()) {
                      //make sign up if there is not any issue

                    }
                  } //this is process when i press on button register,
                  ,
                  height: MediaQuery.of(context).size.height * 0.08,
                  minWidth: double.infinity,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Rehister',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  showAlertDialog(BuildContext context, String titleInDialog, Function press) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          titleInDialog,
         
         
        ),
        actions: [
          // ignore: deprecated_member_use
          RaisedButton(child: Text("Close"), onPressed: press),
        ],
      ),
    );
  }

  Container buildHeadOfPage(String hiddinText) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          hiddinText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
