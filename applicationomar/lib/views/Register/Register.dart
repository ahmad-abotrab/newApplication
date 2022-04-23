import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';
import '/Api/Controller/RegisterController.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({Key key}) : super(key: key);
  final formKeyAccount = GlobalKey<FormState>();
  final formKeyDetials = GlobalKey<FormState>();

  TextEditingController name, pin, email;

  final styleHeaderFormSection = TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white)),
        title: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: formKeyAccount,
                  child: CupertinoFormSection(
                    margin: EdgeInsets.all(12),
                    header: Text(
                      'Account Info',
                      style: styleHeaderFormSection,
                    ),
                    children: [
                      CupertinoTextFormFieldRow(
                        controller: email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        placeholder: 'Enter Email',
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid Email'
                                : null,
                      ),
                      CupertinoTextFormFieldRow(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        placeholder: 'Enter PIN',
                        validator: (pin) => pin != null && pin.length != 4
                            ? 'please enter pin by 4 digit'
                            : null,
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKeyDetials,
                  child: CupertinoFormSection(
                    header: Text(
                      'Detials',
                      style: styleHeaderFormSection,
                    ),
                    margin: EdgeInsets.all(12),
                    children: [
                      CupertinoTextFormFieldRow(
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        placeholder: 'Enter name',
                        validator: (name) =>
                            name != null ? 'please enter name ' : null,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.07),
                        alignment: Alignment.centerLeft,
                        child: GetBuilder<RegisterController>(
                            init: RegisterController(),
                            builder: (_) {
                              return DropdownButton<String>(
                                isDense: true,
                                onChanged: (value) {
                                  Get.find<RegisterController>()
                                      .updateType(value);
                                },
                                hint: Text(
                                    Get.find<RegisterController>().typeOfWork ==
                                                null ||
                                            Get.find<RegisterController>()
                                                    .typeOfWork ==
                                                ''
                                        ? 'Type Work'
                                        : Get.find<RegisterController>()
                                            .typeOfWork,
                                    style: TextStyle(color: Colors.grey[500])),
                                items: Get.find<RegisterController>()
                                    .typeOfWorkList(context)
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem<String>(
                                      value: e, child: Text(e));
                                }).toList(),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: CupertinoButton(
                        color: Colors.grey,
                        child: Text('Submit'),
                        onPressed: () {
                          if (formKeyAccount.currentState.validate() ||
                              formKeyDetials.currentState.validate()) {
                            Fluttertoast.showToast(
                                msg: 'test',
                                fontSize: 18,
                                backgroundColor: Colors.grey,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1);
                          }
                        })),
              ],
            ),
          ),
        ],
      ),
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
}
