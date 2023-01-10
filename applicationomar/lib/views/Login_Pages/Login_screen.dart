import 'package:url_launcher/url_launcher.dart';

import '/Api/Controller/HomeController.dart';
import '/widgets/Language.dart';
import 'package:applicationomar/localization/localizationFile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../main.dart';
import '/Api/Controller/LoginController.dart';
import '/models/Human/Customer.dart';
import '/models/Human/Employee.dart';
import '/views/ChoiceUser/choiceUser.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  Customer customer = new Customer();
  TextEditingController email, password;
  // final key = GlobalKey<FormState>();
  List<Employee> employee = [];
  bool visiable = false;
  @override
  _Loginviewstate createState() => _Loginviewstate();
}

class _Loginviewstate extends State<LoginScreen> {
  @override
  void initState() {
    widget.email = TextEditingController();
    widget.password = TextEditingController();
    widget.employee.add(
      Employee(id: '1', name: 'Ahmad', pin: '5555', career: 'مدير'),
    );
    widget.employee.add(
      Employee(id: '2', name: 'Fadi', pin: '9999', career: 'محاسب'),
    );
    widget.employee.add(
      Employee(id: '3', name: 'Omar', pin: '4567', career: "Manager"),
    );
    widget.employee.add(
      Employee(id: '4', name: 'Milad', pin: '1478', career: 'موظف'),
    );

    super.initState();
  }

  makeLogin() async {
    try {
      final response = await http
          .post(
            Uri.parse('http://codrex.co:3000/api/users/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(<String, String>{
              'username': widget.email.text,
              'password': widget.password.text
            }),
          )
          .timeout(Duration(seconds: 10));

      var source = response.body;
      var jsonDecodeResponse = convert.jsonDecode(source);
      if (jsonDecodeResponse['status'] == 'success') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChoiceUser(
                      company: widget.employee,
                    )));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Text('Error'),
                    ],
                  ),
                  content: Text('login is ' + jsonDecodeResponse['status']),
                ));
      }
    } catch (exception) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Text('Error'),
                  ],
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
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

    ScreenUtil.init(
      context,
      designSize: Size(360, 690),
    );
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //background screen
            Positioned(
                child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            )),
            //body page
            Positioned(
              top: MediaQuery.of(context).size.height * 0.32,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(59),
                      topLeft: Radius.circular(59)),
                ),
              ),
            ),

            Positioned(
                top: MediaQuery.of(context).size.height * 0.033,
                left: MediaQuery.of(context).size.width * 0.8,
                child: GetBuilder<HomeController>(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )),

            //login page
            Positioned(
                left: DemoLocalizations.of(context)
                            .translate("LoginPage", "loginTitlePage") !=
                        "تسجيل الدخول"
                    ? MediaQuery.of(context).size.width * 0.44
                    : MediaQuery.of(context).size.width * 0.36,
                top: MediaQuery.of(context).size.height * 0.05,
                child: Text(
                  DemoLocalizations.of(context)
                      .translate("LoginPage", "loginTitlePage"),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )),
            // //leading page
            // Positioned(
            //     left: MediaQuery.of(context).size.width * 0.02,
            //     top: MediaQuery.of(context).size.height * 0.033,
            //     child: IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         Icons.arrow_back,
            //         color: Colors.white,
            //       ),
            //     )),

            //Daftarak icon and title
            Positioned(
                left: DemoLocalizations.of(context)
                            .translate("LoginPage", "NameProject") ==
                        'Daftarak'
                    ? MediaQuery.of(context).size.width * 0.25
                    : MediaQuery.of(context).size.width * 0.35,
                top: MediaQuery.of(context).size.height * 0.15,
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Image.asset('assets/images/notebook.png'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Text(
                      DemoLocalizations.of(context)
                          .translate("LoginPage", "NameProject"),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),

            //Form (email - password - login - forgetPassword)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: Form(
                    key: widget.key,
                    child: Column(
                      children: [
                        TextFieldForEmailOrPassword(
                          hintText: DemoLocalizations.of(context).translate(
                              "LoginPage", "FieldEmailHinitAndLable"),
                          color: Theme.of(context).hintColor == Colors.black
                              ? Colors.grey
                              : Theme.of(context).hintColor,
                          vaildatorText: DemoLocalizations.of(context)
                              .translate(
                                  "LoginPage", "FieldEmailHinitAndLable"),
                          lable: DemoLocalizations.of(context).translate(
                              "LoginPage", "FieldEmailHinitAndLable"),
                          controller: widget.email,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        GetBuilder<LoginController>(
                            init: LoginController(),
                            builder: (_) {
                              return TextFieldForEmailOrPassword(
                                color:
                                    Theme.of(context).hintColor == Colors.black
                                        ? Colors.grey
                                        : Theme.of(context).hintColor,
                                hintText: DemoLocalizations.of(context)
                                    .translate("LoginPage",
                                        "FieldPasswordHinitAndLable"),
                                vaildatorText: DemoLocalizations.of(context)
                                    .translate("LoginPage",
                                        "FieldPasswordHinitAndLable"),
                                lable: DemoLocalizations.of(context).translate(
                                    "LoginPage", "FieldPasswordHinitAndLable"),
                                controller: widget.password,
                                visiable: Get.find<LoginController>().visable,
                              );
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(32),
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.withOpacity(0.7),
                                Colors.black54,
                              ],
                            ),
                          ),
                          child: MaterialButton(
                              child: Text(
                                DemoLocalizations.of(context)
                                    .translate("LoginPage", "ButtonLogin"),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChoiceUser(
                                              company: widget.employee,
                                            )));
                              }),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.032,
                        ),
                        Container(
                            child: Text(
                          DemoLocalizations.of(context)
                              .translate("LoginPage", "ForgetPasswordButton"),
                          style: TextStyle(
                              color: Theme.of(context).hintColor,
                              // fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              decoration: TextDecoration.underline),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //powerd by coderx.co company
            Positioned(
              left: DemoLocalizations.of(context)
                          .translate("LoginPage", "PowerdBy") ==
                      "Powerd by"
                  ? MediaQuery.of(context).size.width * 0.23
                  : MediaQuery.of(context).size.width * 0.18,
              top: MediaQuery.of(context).size.height * 0.94,
              child: Row(
                children: [
                  Text(
                    DemoLocalizations.of(context)
                        .translate("LoginPage", "PowerdBy"),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  Container(
                      child: MaterialButton(onPressed: () async {
                        const url = "https://codrex.co/";
                        try {
                          await launch(url);
                        } catch (ex) {
                          print(ex);
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text('warning'),
                                    content: Text('could not open this url'),
                                  ));
                        }

                        // can't launch url, there is some error
                      }),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.07,
                      decoration: BoxDecoration(
                          // color: Colors.black,
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/cr logopng.png')))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextFieldForEmailOrPassword extends StatelessWidget {
  TextFieldForEmailOrPassword({
    Key key,
    @required this.hintText,
    @required this.vaildatorText,
    @required this.controller,
    @required this.color,
    @required this.lable,
    this.visiable,
  }) : super(key: key);

  final hintText, vaildatorText, lable;
  TextEditingController controller;
  Color color;

  bool visiable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.015),
          child: Text(
            hintText,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        TextFormField(
          obscureText: visiable == null ? false : !visiable,
          validator: (value) => value.isEmpty ? vaildatorText : null,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: color),
            labelText: lable,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(
                  color: Colors.white,
                  style: BorderStyle.solid,
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: color,
              ),
            ),
            prefixIcon: hintText == 'Email' || hintText == 'البريد الالكتروني'
                ? IconButton(
                    onPressed: () {
                      Get.find<LoginController>()
                          .updateVisiable(!Get.find<LoginController>().visable);
                    },
                    icon: Icon(Icons.email, color: color),
                  )
                : IconButton(
                    onPressed: () {
                      Get.find<LoginController>()
                          .updateVisiable(!Get.find<LoginController>().visable);
                    },
                    icon: Icon(
                        Get.find<LoginController>().visable
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: color),
                  ),
          ),
        )
      ],
    );
  }
}
