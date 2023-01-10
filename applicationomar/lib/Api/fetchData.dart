import 'package:applicationomar/localization/localizationFile.dart';
import 'package:applicationomar/models/Todo.dart';

import '/models/Debts/DebtsModel.dart';
import '/models/Human/Customer.dart';
import '/models/Human/Employee.dart';
import '/models/Operations/Sell.dart';
import '/models/Operations/SellUp.dart';
import '/models/Warehouse/product.dart';

class FetchData {
  static List<Todo> todo = [];

  List<String> years = [
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
  ];

  static List<String> months(context) {
    return [
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Jan"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Feb"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Mar"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Apr"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "May"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Jun"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Jul"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Aug"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Sep"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Oct"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Nov"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "months", key3: "Dec"),
    ];
  }

  static List<String> week(context) {
    return [
      DemoLocalizations.of(context).translate("LogsScreen", "weeks", key3: "1"),
      DemoLocalizations.of(context).translate("LogsScreen", "weeks", key3: "2"),
      DemoLocalizations.of(context).translate("LogsScreen", "weeks", key3: "3"),
      DemoLocalizations.of(context).translate("LogsScreen", "weeks", key3: "4"),
    ];
  }

  static List<String> days(context) {
    return [
      DemoLocalizations.of(context)
          .translate("LogsScreen", "days", key3: "Sun"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "days", key3: "Mon"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "days", key3: "Tus"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "days", key3: "Wed"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "days", key3: "Thr"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "days", key3: "Fri"),
      DemoLocalizations.of(context)
          .translate("LogsScreen", "days", key3: "Sat"),
    ];
  }

  List<Sell> sells = [
    Sell(
        id: '1',
        value: 20.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '2',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '3',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '4',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '5',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '6',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '6',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '7',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '8',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '9',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
        id: '10',
        value: 40.0,
        customer: Customer(
          mobile: '0944932576',
          phone: '3280690',
          id: '1',
          name: "الحاج ابو محمد",
          remainingAmount: 50.0,
          amountPaid: 90.0,
        ),
        date: DateTime.now()),
    Sell(
      id: '11',
      date: DateTime.now(),
      value: 240.0,
      customer: Customer(
        id: '1',
        name: "Ahmad",
        remainingAmount: 140.0,
        amountPaid: 100.0,
      ),
      productsSell: [
        SellUp(
          idProduct: '3',
          nameProduct: 'Comcamber',
          quantity: 8,
          unitPrice: 98.0,
        ),
        SellUp(
          idProduct: '6',
          nameProduct: 'tomato',
          quantity: 89,
          unitPrice: 128.0,
        ),
      ],
    ),
  ];

  List<Customer> customerList = [
    Customer(
      mobile: '0944932576',
      phone: '3280690',
      id: '1',
      name: "الحاج ابو محمد",
      remainingAmount: 50,
      amountPaid: 90,
    ),
    Customer(
      id: '1',
      name: "Ahmad",
      remainingAmount: 50,
      amountPaid: 90,
    ),
    Customer(
      id: '1',
      name: "حيان البوزوا",
      remainingAmount: 50,
      amountPaid: 90,
    ),
    Customer(
      id: '1',
      name: "رامي عياش",
      remainingAmount: 50,
      amountPaid: 90,
    ),
    Customer(
      id: '1',
      name: "فؤاد ابراهيم",
      remainingAmount: 50,
      amountPaid: 90,
    ),
  ];

  List<Employee> employeeList = [
    Employee(name: "الحاج ابو محمد", career: ''),
    Employee(name: "الحاج ابو آحمد"),
    Employee(name: "حيان البوزوا"),
    Employee(name: "رامي عياش"),
    Employee(name: "فؤاد ابراهيم"),
  ];

  static List<Debts> deptsProducts = [
    Debts(
      customer: Customer(name: "الحاج ابو محمد"),
      value: 4000,
      date: DateTime.now(),
    ),
    Debts(
      customer: Customer(name: "الحاج ابو محمد"),
      value: 48900,
      date: DateTime.now(),
    ),
    Debts(
      customer: Customer(name: "حيان البوزوا"),
      value: 67000,
      date: DateTime.now(),
    ),
    Debts(
      customer: Customer(name: "رامي عياش"),
      value: 345000,
      date: DateTime.now(),
    ),
    Debts(
      customer: Customer(name: "فؤاد ابراهيم"),
      value: 543000,
      date: DateTime.now(),
    ),
  ];

  getListYears() {
    return years;
  }

  List<Employee> getEmployeeList() {
    return employeeList;
  }

  List<Customer> getCustomerlist() {
    return customerList;
  }

  getListProducts() {
    List<Product> productsList = <Product>[
      Product(
          name: 'shoses Nike',
          catagory: 'shoseeeeeeee',
          subCategory: 'sport',
          allQuantity: 52,
          companyName: 'codrex.co',
          minAmount: 19,
          price: 522.0),
      Product(
          name: 'shoses static',
          catagory: 'shose',
          subCategory: 'classies',
          allQuantity: 152,
          minAmount: 3,
          companyName: 'codrex.co',
          price: 482.0),
      Product(
          name: 'coocamber',
          catagory: 'food',
          subCategory: 'fruit',
          allQuantity: 49,
          minAmount: 3,
          companyName: 'codrex.co',
          price: 590.0),
      Product(
          name: 'iphohe 13',
          catagory: 'phone',
          minAmount: 3,
          allQuantity: 52,
          companyName: 'codrex.co',
          price: 102.0),
      Product(
          name: 'iphone 12',
          catagory: 'phone',
          allQuantity: 52,
          minAmount: 3,
          companyName: 'codrex.co',
          price: 155.0),
      Product(
          name: 'iphone 138',
          catagory: 'phone',
          allQuantity: 532,
          minAmount: 3,
          companyName: 'codrex.co',
          price: 15553335.0),
      Product(
          name: 'macbook air',
          catagory: 'labtob',
          allQuantity: 82,
          minAmount: 3,
          companyName: 'codrex.co',
          price: 600.32),
      Product(
          name: 'totmato',
          catagory: 'food',
          subCategory: 'frrrruit',
          allQuantity: 56,
          minAmount: 3,
          companyName: 'codrex.co',
          price: 122.0),
      Product(
          name: 'totmato',
          allQuantity: 52,
          catagory: 'gg',
          companyName: 'codrex.co',
          subCategory: 'qq',
          minAmount: 3,
          price: 142.0),
    ];
    return productsList;
  }

  convertProductsListToMapCategory() {
    //here should get Products from database
    List<Product> productsList = getListProducts();
    Map<String, List<String>> category = {};
    for (Product product in productsList) {
      try {
        if (category[product.catagory] == null) {
            category[product.catagory] = [];
          }
        if (product.subCategory != null) {
          
          category[product.catagory].add(product.subCategory);
        } else {
          if (category[product.catagory].isEmpty ||
              category[product.catagory].length == 0 ||
              category[product.catagory] == null) {
            category[product.catagory] = [];
          }
        }
      } catch (exception) {
        category[product.catagory] = [];
        category[product.catagory].clear();

        if (product.subCategory != null) {
          category[product.catagory].add(product.subCategory);
        }
      }
    }
    return category;
  }
}
