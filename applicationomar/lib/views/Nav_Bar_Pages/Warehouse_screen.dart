// ignore: must_be_immutable
import 'dart:async';
import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '/Api/Controller/ListCategoryUpdated.dart';
import '/Api/Controller/TabBarViewProductController.dart';
import '/Api/Controller/ViewProductFilttedController.dart';
import '/Api/fetchData.dart';
import '/models/Warehouse/product.dart';

// ignore: must_be_immutable
class WareHouse extends StatelessWidget {
  WareHouse({Key key}) : super(key: key);
  TextEditingController nameProductController = TextEditingController();
  TextEditingController minAmountController = TextEditingController();
  TextEditingController subCategory = TextEditingController();
  TextEditingController category = TextEditingController();
  final addProductFormKey = GlobalKey<FormState>();
  final _formkey = GlobalKey<FormState>();
  final _innerformkey = GlobalKey<FormState>();
  List<String> categoryitems = ['add new Category'];
  List<String> subcategoryitems = ['add new sub category'];
  List products = [];
  String _chosenvalue;
  String _chosenvalue2;
  String textinput;
  Map<String, List<String>> categoryMap =
      FetchData().convertProductsListToMapCategory();
  bool thereSubCategoty = false;
  String chosenCategory = 'category';
  String chosenSubCategory;
  List<String> subCategoryDropDown = [];
  Function(Object) callback;
  int index = 0;
  bool allProduct = true, mostPopular = false;
  String nonValueDropDowm;
  List<String> emptyList;

  bool showSubCategory = false;

  Future<dynamic> addProductMethodByAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              titlePadding: EdgeInsets.only(bottom: 8.0),
              title: Container(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white)),
                        Text(
                          DemoLocalizations.of(context).translate(
                              'Warehouse', 'Add Products',
                              key3: 'add_product'),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )),
              content: SingleChildScrollView(
                child: GetBuilder<ListCategoryUpdatedController>(
                  init: ListCategoryUpdatedController(context),
                  builder: (_) {
                    return Column(
                      children: [
                        Form(
                          key: addProductFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: TextFormField(
                                  controller: nameProductController,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      labelText: DemoLocalizations.of(context)
                                          .translate(
                                              'Warehouse', 'Add Products',
                                              key3: 'prod_name'),
                                      labelStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  validator: (input) => input.isEmpty
                                      ? DemoLocalizations.of(context).translate(
                                          'Warehouse', 'Add Products',
                                          key3: 'validatorNameProduct')
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  elevation: 5,
                                  isDense: true,
                                  iconSize: 35,
                                  dropdownColor:
                                      Theme.of(context).backgroundColor,
                                  value: _chosenvalue,
                                  hint: Text(
                                    DemoLocalizations.of(context).translate(
                                        'Warehouse', 'Add Products',
                                        key3: 'choose_cat'),
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  iconEnabledColor: Colors.blueGrey,
                                  iconDisabledColor: Colors.blue,
                                  items:
                                      Get.find<ListCategoryUpdatedController>()
                                          .category
                                          .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor)),
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    Get.find<ListCategoryUpdatedController>()
                                        .updateCategoryValue(value);
                                    if (value ==
                                        Get.find<
                                                ListCategoryUpdatedController>()
                                            .category
                                            .first) {
                                      dialogAddCategoryOrSubCategory(
                                          context,
                                          Text(DemoLocalizations.of(context)
                                              .translate(
                                                  'Warehouse', 'Add Products',
                                                  key3: 'choose_subcat')),
                                          DemoLocalizations.of(context)
                                              .translate(
                                                  'Warehouse', 'Add Products',
                                                  key3: 'add_cat'),
                                          DemoLocalizations.of(context)
                                              .translate('Warehouse',
                                                  'Add Products',
                                                  key3: 'NameCat'),
                                          category,
                                          'category');
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: DropdownButton<String>(
                                    dropdownColor:
                                        Theme.of(context).backgroundColor,
                                    isExpanded: true,
                                    elevation: 5,
                                    isDense: true,
                                    iconSize: 35,
                                    value: _chosenvalue2,
                                    hint: Text(
                                      DemoLocalizations.of(context).translate(
                                          'Warehouse', 'Add Products',
                                          key3: 'choose_subcat'),
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    iconEnabledColor: Colors.blueGrey,
                                    iconDisabledColor: Colors.blue,
                                    items: Get.find<
                                            ListCategoryUpdatedController>()
                                        .subCategrory
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .hintColor)),
                                      );
                                    }).toList(),
                                    onChanged: (String value) {
                                      Get.find<ListCategoryUpdatedController>()
                                          .updateSubCategoryValue(value);
                                      // _chosenvalue2 = value;
                                      if (value ==
                                          Get.find<
                                                  ListCategoryUpdatedController>()
                                              .subCategrory
                                              .first) {
                                        dialogAddCategoryOrSubCategory(
                                          context,
                                          Text(DemoLocalizations.of(context)
                                              .translate(
                                                  'Warehouse', 'Add Products',
                                                  key3: 'add_cat')),
                                          DemoLocalizations.of(context)
                                              .translate(
                                                  'Warehouse', 'Add Products',
                                                  key3: 'add_subcat'),
                                          DemoLocalizations.of(context)
                                              .translate(
                                                  'Warehouse', 'Add Products',
                                                  key3: 'NameSubCat'),
                                          subCategory,
                                          'subCategory',
                                        );
                                      }
                                    },
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: TextFormField(
                                  controller: minAmountController,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      labelText: DemoLocalizations.of(context)
                                          .translate(
                                              'Warehouse', 'Add Products',
                                              key3: 'minimuim_text'),
                                      labelStyle: TextStyle(fontSize: 18),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  validator: (input) => input.trim().isEmpty
                                      ? DemoLocalizations.of(context).translate(
                                          'Warehouse', 'Add Products',
                                          key3: 'validatorMinAmount')
                                      : null,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).hintColor ==
                                              Colors.white
                                          ? Colors.blue
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        DemoLocalizations.of(context).translate(
                                            'Warehouse', 'Add Products',
                                            key3: 'backButton'),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).hintColor ==
                                              Colors.white
                                          ? Colors.blue
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (addProductFormKey.currentState
                                            .validate()) {
                                          if (_chosenvalue == null ||
                                              _chosenvalue2 == null ||
                                              _chosenvalue == '' ||
                                              _chosenvalue2 == '') {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                          DemoLocalizations.of(
                                                                  context)
                                                              .translate(
                                                        'Warehouse',
                                                        'Add Products',
                                                        key3: "titleDialog",
                                                      )),
                                                      content: Text(
                                                          DemoLocalizations.of(
                                                                  context)
                                                              .translate(
                                                        'Warehouse',
                                                        'Add Products',
                                                        key3: "contentDialog",
                                                      )),
                                                      actions: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              DemoLocalizations
                                                                      .of(context)
                                                                  .translate(
                                                            'Warehouse',
                                                            'Add Products',
                                                            key3: "backBtn",
                                                          )),
                                                        )
                                                      ],
                                                    ));
                                          } else {
                                            showToast(context: context);
                                          }
                                        }
                                      },
                                      child: Text(
                                        DemoLocalizations.of(context).translate(
                                            'Warehouse', 'Add Products',
                                            key3: 'AddButton'),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> dialogAddCategoryOrSubCategory(BuildContext context, title,
      hintText, validator, controller, sign) async {
    return showDialog(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: EdgeInsets.only(
              top: 8.0,
            ),
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                Text(
                  sign == 'category'
                      ? DemoLocalizations.of(context).translate(
                          'Warehouse', 'Add Products', key3: 'add_cat')
                      : DemoLocalizations.of(context).translate(
                          'Warehouse', 'Add Products',
                          key3: 'add_subcat'),
                ),
              ],
            ),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Form(
                    child: TextFormField(
                        validator: (input) => input.trim().isEmpty
                            ? 'please fill this filed'
                            : null,
                        controller: sign == 'category' ? category : subCategory,
                        decoration: InputDecoration(
                            labelText: sign == 'category'
                                ? DemoLocalizations.of(context).translate(
                                    'Warehouse', 'Add Products',
                                    key3: 'add_cat')
                                : DemoLocalizations.of(context).translate(
                                    'Warehouse', 'Add Products',
                                    key3: 'add_subcat'),
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    key: _innerformkey,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  InkWell(
                    onTap: () {
                      if (_innerformkey.currentState.validate()) {
                        addProductFormKey.currentState.save();

                        if (sign ==
                            DemoLocalizations.of(context).translate(
                                'Warehouse', 'Add Products',
                                key3: 'add_cat')) {
                          Get.find<ListCategoryUpdatedController>()
                              .addToCategoryList(1, category.text);

                          Get.find<ListCategoryUpdatedController>()
                              .updateCategoryValue(category.text);
                          category.clear();
                          Navigator.pop(context);
                        } else {
                          Get.find<ListCategoryUpdatedController>()
                              .addToSubCategoryList(1, subCategory.text);

                          Get.find<ListCategoryUpdatedController>()
                              .updateSubCategoryValue(subCategory.text);

                          subCategory.clear();
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF33b17c),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                      ),
                      child: Text(
                        DemoLocalizations.of(context).translate(
                            'Warehouse', 'Add Products',
                            key3: 'add_product'),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showToast({
    @required BuildContext context,
  }) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Row(
          children: [
            Icon(
              Icons.done_all,
              color: Colors.green,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            Expanded(
              child: Text(DemoLocalizations.of(context).translate(
                  'Warehouse', 'Add Products',
                  key3: 'toastShowAddProduct')),
            ),
          ],
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
    Timer(Duration(seconds: 1), () => overlayEntry.remove());
  }

  @override
  Widget build(BuildContext context) {
    //create category and sub category list
    var getBuilder = GetBuilder<ViewProductFiltterdController>(
        init: ViewProductFiltterdController(),
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(28),
                      dropdownColor: Theme.of(context).backgroundColor,
                      elevation: 8,
                      hint: Text(
                        DemoLocalizations.of(context)
                            .translate('Warehouse', 'Category'),
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onChanged: (String value) {
                        Get.find<ViewProductFiltterdController>()
                            .updateValueCategory(value);

                        Get.find<ViewProductFiltterdController>()
                            .updateListSubCategory(categoryMap[value]);
                        Get.find<ViewProductFiltterdController>()
                            .updateListProduct();
                      },
                      value: ViewProductFiltterdController.categoryItem,
                      style: TextStyle(color: Colors.black),
                      items: categoryMap.keys.toList().map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Container(
                              decoration: BoxDecoration(),
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Get.find<ViewProductFiltterdController>().showSubCategroy
                    ? Expanded(
                        child: Container(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(28),
                            dropdownColor: Theme.of(context).backgroundColor,
                            elevation: 8,
                            hint: Text(
                              DemoLocalizations.of(context)
                                  .translate('Warehouse', 'subCategory'),
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onChanged: (String value) {
                              Get.find<ViewProductFiltterdController>()
                                  .updateValueSubCategory(value);
                              Get.find<ViewProductFiltterdController>()
                                  .updateListProduct();
                            },
                            value: ViewProductFiltterdController
                                        .subCategoryItem ==
                                    null
                                ? nonValueDropDowm
                                : ViewProductFiltterdController.subCategoryItem,
                            style: TextStyle(color: Colors.black),
                            items: Get.find<ViewProductFiltterdController>()
                                    .subCategory
                                    .isEmpty
                                ? null
                                : Get.find<ViewProductFiltterdController>()
                                    .subCategory
                                    .map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Container(
                                          decoration: BoxDecoration(),
                                          child: Text(
                                            e.toString(),
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          )),
                                    );
                                  }).toList(),
                          ),
                        ),
                      )
                    : Expanded(child: Container()),
              ],
            ),
          );
        });

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04),
                  child: Text(
                    DemoLocalizations.of(context)
                        .translate('Warehouse', 'titleWarHouse'),
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: MediaQuery.of(context).size.width * 0.06),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(25)),
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: MaterialButton(
                    child: Text(
                      DemoLocalizations.of(context)
                          .translate('Warehouse', 'add_products_text'),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      addProductMethodByAlertDialog(context);
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.07,
            ),
            getBuilder,
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            GetBuilder<ViewProductFiltterdController>(
                init: ViewProductFiltterdController(),
                builder: (_) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.016),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.find<ViewProductFiltterdController>()
                                    .updateAllProductBoolean(true);
                                Get.find<ViewProductFiltterdController>()
                                    .updateMostPopularBoolean(false);
                                Get.find<ViewProductFiltterdController>()
                                    .updateIndex(0);
                                Get.find<ViewProductFiltterdController>()
                                    .updateToCreateAllProductsList();
                                Get.find<ViewProductFiltterdController>()
                                    .updateValueCategory(null);
                                Get.find<ViewProductFiltterdController>()
                                    .updateValueSubCategory(null);
                              },
                              child: Text(
                                DemoLocalizations.of(context)
                                    .translate('Warehouse', 'AllProduct'),
                                style: TextStyle(
                                    decoration: Get.find<
                                                ViewProductFiltterdController>()
                                            .allProduct
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    fontWeight: Get.find<
                                                ViewProductFiltterdController>()
                                            .allProduct
                                        ? FontWeight.w600
                                        : FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.find<ViewProductFiltterdController>()
                                      .updateAllProductBoolean(false);
                                  Get.find<ViewProductFiltterdController>()
                                      .updateMostPopularBoolean(true);
                                  Get.find<ViewProductFiltterdController>()
                                      .updateIndex(1);
                                },
                                child: Text(
                                  DemoLocalizations.of(context)
                                      .translate('Warehouse', 'MostPopular'),
                                  style: TextStyle(
                                      decoration: Get.find<
                                                  ViewProductFiltterdController>()
                                              .mostPopular
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      fontWeight: Get.find<
                                                  ViewProductFiltterdController>()
                                              .mostPopular
                                          ? FontWeight.w600
                                          : FontWeight.normal),
                                )),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            GetBuilder<ViewProductFiltterdController>(
                init: ViewProductFiltterdController(),
                builder: (_) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: Get.find<ViewProductFiltterdController>()
                          .products
                          .length,
                      itemBuilder: (_, int index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              ListTile(
                                dense: true,
                                visualDensity: VisualDensity.comfortable,
                                enableFeedback: true,
                                // isThreeLine: true,
                                leading: Text(
                                  DemoLocalizations.of(context)
                                      .translate('Warehouse', 'Col_QAT'),
                                  style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                title: Text(
                                  DemoLocalizations.of(context)
                                      .translate('Warehouse', 'Col_product'),
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                trailing: Text(
                                  DemoLocalizations.of(context)
                                      .translate('Warehouse', 'Col_Price'),
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Divider(thickness: 2),
                            ],
                          );
                        } else {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            actions: [
                              IconSlideAction(
                                caption: DemoLocalizations.of(context)
                                    .translate('Warehouse', 'Close_slid'),
                                color: Colors.grey,
                                icon: Icons.close,
                              ),
                              IconSlideAction(
                                caption: DemoLocalizations.of(context)
                                    .translate('Warehouse', 'More_slid'),
                                color: Colors.green[300],
                                icon: Icons.more_vert,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          MoreInformationAboutProduct(
                                              index: index));
                                },
                              ),
                              IconSlideAction(
                                caption: DemoLocalizations.of(context)
                                    .translate('Warehouse', 'Del_slid'),
                                color: Colors.red[300],
                                icon: Icons.delete,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        WarningDeleteProduct(index: index),
                                  );
                                },
                              ),
                            ],
                            child: ListTile(
                              // isThreeLine: true,
                              leading: Text(
                                Get.find<ViewProductFiltterdController>()
                                    .products[index]
                                    .allQuantity
                                    .toString(),
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),

                              title: Text(
                                Get.find<ViewProductFiltterdController>()
                                    .products[index]
                                    .name
                                    .toString(),
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Text(
                                Get.find<ViewProductFiltterdController>()
                                    .products[index]
                                    .price
                                    .toString(),
                                style: TextStyle(
                                    color: Theme.of(context).hintColor ==
                                            Colors.white
                                        ? Colors.white
                                        : Colors.green,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class MoreInformationAboutProduct extends StatelessWidget {
  const MoreInformationAboutProduct({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(Get.find<ViewProductFiltterdController>().products[index].name),
      content: SingleChildScrollView(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: DemoLocalizations.of(context)
                      .translate('Warehouse', 'More', key3: 'Quantity'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '     '.toString(),
                    ),
                    TextSpan(
                        text: Get.find<ViewProductFiltterdController>()
                            .products[index]
                            .allQuantity
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ]),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.03),
            RichText(
              text: TextSpan(
                  text: DemoLocalizations.of(context)
                      .translate('Warehouse', 'More', key3: 'Min_Quantity'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                        text: Get.find<ViewProductFiltterdController>()
                            .products[index]
                            .minAmount
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ]),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.03),
            RichText(
              text: TextSpan(
                  text: DemoLocalizations.of(context)
                      .translate('Warehouse', 'More', key3: 'NameCompany'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                        text: Get.find<ViewProductFiltterdController>()
                            .products[index]
                            .companyName
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ]),
            ),
          ],
        )),
      ),
      actions: [
        MaterialButton(
            child: Text(DemoLocalizations.of(context)
                .translate('Warehouse', 'More', key3: 'buttonBack')),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}

class WarningDeleteProduct extends StatelessWidget {
  const WarningDeleteProduct({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Icon(Icons.warning, color: Colors.yellow),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text('Warning'),
          ],
        ),
        content: Text('you sure want delete this product '),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              MaterialButton(
                onPressed: () {
                  Product element =
                      Get.find<ViewProductFiltterdController>().products[index];

                  Get.find<ViewProductFiltterdController>()
                      .removeAtIndexFromProducts(index);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    backgroundColor: Colors.grey[600],
                    elevation: 12,
                    duration: Duration(seconds: 2),
                    content: RichText(
                      text: TextSpan(
                        text: 'You delete Product : ',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                        children: <TextSpan>[
                          TextSpan(
                              text: element.name,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        Get.find<ViewProductFiltterdController>()
                            .insertNewElementInList(index, element);
                      },
                    ),
                  ));
                },
                child: Text('okay'),
              )
            ],
          )
        ]);
  }
}

// Dismissible(
                          //   key: UniqueKey(),
                          //   behavior: HitTestBehavior.opaque,
                          //   movementDuration: Duration(milliseconds: 900),
                          //   onDismissed: (direction)  {
                          //     if (direction == DismissDirection.endToStart) {
                          //       
                          //       showDialog(
                          //           context: context,
                          //           builder: (context) => AlertDialog(
                          //                 shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.all(
                          //                         Radius.circular(25.0))),
                          //                 contentPadding: EdgeInsets.only(
                          //                   top: 8.0,
                          //                 ),
                          //                 titlePadding:
                          //                     EdgeInsets.only(bottom: 8.0),
                          //                 title: Container(
                          //                   padding: EdgeInsets.only(
                          //                       top: 16.0, bottom: 16.0),
                          //                   decoration: BoxDecoration(
                          //                     color: Color(0xFF7D7E7E),
                          //                     borderRadius: BorderRadius.only(
                          //                         topLeft:
                          //                             Radius.circular(25.0),
                          //                         topRight:
                          //                             Radius.circular(25.0)),
                          //                   ),
                          //                   child: Row(
                          //                     children: [
                          //                       SizedBox(
                          //                         width: MediaQuery.of(context)
                          //                                 .size
                          //                                 .width *
                          //                             0.03,
                          //                       ),
                          //                       Icon(
                          //                         Icons.warning,
                          //                         color: Colors.yellow,
                          //                       ),
                          //                       Text(
                          //                         'Warning',
                          //                         style: TextStyle(
                          //                             color: Colors.white),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 content: SingleChildScrollView(
                          //                   child: Padding(
                          //                     padding: EdgeInsets.all(
                          //                         MediaQuery.of(context)
                          //                                 .size
                          //                                 .width *
                          //                             0.03),
                          //                     child: Text(
                          //                         'you sure want to delete this product , id you press okay you will delete from database'),
                          //                   ),
                          //                 ),

                          //                 actions: [
                          //                   MaterialButton(
                          //                     onPressed: () {},
                          //                     child: Text('okay'),
                          //                   ),
                          //                 ],


                       
                          //               ));
                          //     } else {
                          //       showDialog(
                          //           context: context,
                          //           builder: (context) => AlertDialog(
                          //                 content: Text("Hello Ahmad"),
                          //                 actions: [
                          //                   MaterialButton(
                          //                       onPressed: () {},
                          //                       child: Text('Okay')),
                          //                 ],
                          //               ));
                          //     }
                          //   },
                          //   secondaryBackground: Container(
                          //     color: Colors.red,
                          //     margin: EdgeInsets.symmetric(horizontal: 15),
                          //     alignment: Alignment.centerRight,
                          //     child: Icon(
                          //       Icons.delete,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          //   background: Container(
                          //       color: Colors.green,
                          //       margin: EdgeInsets.symmetric(horizontal: 15),
                          //       alignment: Alignment.centerRight,
                          //       child: Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Icon(
                          //           Icons.edit,
                          //           color: Colors.white,
                          //         ),
                          //       )),
 

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Slidable Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Slidable Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late final SlidableController slidableController;
//   final List<_HomeItem> items = List.generate(
//     20,
//     (i) => _HomeItem(
//       i,
//       'Tile n°$i',
//       _getSubtitle(i),
//       _getAvatarColor(i),
//     ),
//   );

//   @protected
//   void initState() {
//     slidableController = SlidableController(
//       onSlideAnimationChanged: handleSlideAnimationChanged,
//       onSlideIsOpenChanged: handleSlideIsOpenChanged,
//     );
//     super.initState();
//   }

//   Animation<double>? _rotationAnimation;
//   Color _fabColor = Colors.blue;

//   void handleSlideAnimationChanged(Animation<double>? slideAnimation) {
//     setState(() {
//       _rotationAnimation = slideAnimation;
//     });
//   }

//   void handleSlideIsOpenChanged(bool? isOpen) {
//     setState(() {
//       _fabColor = isOpen! ? Colors.green : Colors.blue;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: OrientationBuilder(
//           builder: (context, orientation) => _buildList(
//               context,
//               orientation == Orientation.portrait
//                   ? Axis.vertical
//                   : Axis.horizontal),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: _fabColor,
//         onPressed: null,
//         child: _rotationAnimation == null
//             ? Icon(Icons.add)
//             : RotationTransition(
//                 turns: _rotationAnimation!,
//                 child: Icon(Icons.add),
//               ),
//       ),
//     );
//   }

//   Widget _buildList(BuildContext context, Axis direction) {
//     return ListView.builder(
//       scrollDirection: direction,
//       itemBuilder: (context, index) {
//         final Axis slidableDirection =
//             direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
//         var item = items[index];
//         if (item.index < 8) {
//           return _getSlidableWithLists(context, index, slidableDirection);
//         } else {
//           return _getSlidableWithDelegates(context, index, slidableDirection);
//         }
//       },
//       itemCount: items.length,
//     );
//   }

//   Widget _getSlidableWithLists(
//       BuildContext context, int index, Axis direction) {
//     final _HomeItem item = items[index];
//     //final int t = index;
//     return Slidable(
//       key: Key(item.title),
//       controller: slidableController,
//       direction: direction,
//       dismissal: SlidableDismissal(
//         child: SlidableDrawerDismissal(),
//         onDismissed: (actionType) {
//           _showSnackBar(
//               context,
//               actionType == SlideActionType.primary
//                   ? 'Dismiss Archive'
//                   : 'Dimiss Delete');
//           setState(() {
//             items.removeAt(index);
//           });
//         },
//       ),
//       actionPane: _getActionPane(item.index)!,
//       actionExtentRatio: 0.25,
//       child: direction == Axis.horizontal
//           ? VerticalListItem(items[index])
//           : HorizontalListItem(items[index]),
//       actions: <Widget>[
//         IconSlideAction(
//           caption: 'Archive',
//           color: Colors.blue,
//           icon: Icons.archive,
//           onTap: () => _showSnackBar(context, 'Archive'),
//         ),
//         IconSlideAction(
//           caption: 'Share',
//           color: Colors.indigo,
//           icon: Icons.share,
//           onTap: () => _showSnackBar(context, 'Share'),
//         ),
//       ],
//       secondaryActions: <Widget>[
//         Container(
//           height: 800,
//           color: Colors.green,
//           child: Text('a'),
//         ),
//         IconSlideAction(
//           caption: 'More',
//           color: Colors.grey.shade200,
//           icon: Icons.more_horiz,
//           onTap: () => _showSnackBar(context, 'More'),
//           closeOnTap: false,
//         ),
//         IconSlideAction(
//           caption: 'Delete',
//           color: Colors.red,
//           icon: Icons.delete,
//           onTap: () => _showSnackBar(context, 'Delete'),
//         ),
//       ],
//     );
//   }

//   Widget _getSlidableWithDelegates(
//       BuildContext context, int index, Axis direction) {
//     final _HomeItem item = items[index];

//     return Slidable.builder(
//       key: Key(item.title),
//       controller: slidableController,
//       direction: direction,
//       dismissal: SlidableDismissal(
//         child: SlidableDrawerDismissal(),
//         closeOnCanceled: true,
//         onWillDismiss: (item.index != 10)
//             ? null
//             : (actionType) {
//                 return showDialog<bool>(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text('Delete'),
//                       content: Text('Item will be deleted'),
//                       actions: <Widget>[
//                         TextButton(
//                           child: Text('Cancel'),
//                           onPressed: () => Navigator.of(context).pop(false),
//                         ),
//                         TextButton(
//                           child: Text('Ok'),
//                           onPressed: () => Navigator.of(context).pop(true),
//                         ),
//                       ],
//                     );
//                   },
//                 ) as FutureOr<bool>;
//               } as FutureOr<bool> Function(SlideActionType?)?,
//         onDismissed: (actionType) {
//           _showSnackBar(
//               context,
//               actionType == SlideActionType.primary
//                   ? 'Dismiss Archive'
//                   : 'Dimiss Delete');
//           setState(() {
//             items.removeAt(index);
//           });
//         },
//       ),
//       actionPane: _getActionPane(item.index)!,
//       actionExtentRatio: 0.25,
//       child: direction == Axis.horizontal
//           ? VerticalListItem(items[index])
//           : HorizontalListItem(items[index]),
//       actionDelegate: SlideActionBuilderDelegate(
//           actionCount: 2,
//           builder: (context, index, animation, renderingMode) {
//             if (index == 0) {
//               return IconSlideAction(
//                 caption: 'Archive',
//                 color: renderingMode == SlidableRenderingMode.slide
//                     ? Colors.blue.withOpacity(animation!.value)
//                     : (renderingMode == SlidableRenderingMode.dismiss
//                         ? Colors.blue
//                         : Colors.green),
//                 icon: Icons.archive,
//                 onTap: () async {
//                   var state = Slidable.of(context);
//                   var dismiss = await (showDialog<bool>(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('Delete'),
//                         content: Text('Item will be deleted'),
//                         actions: <Widget>[
//                           TextButton(
//                             child: Text('Cancel'),
//                             onPressed: () => Navigator.of(context).pop(false),
//                           ),
//                           TextButton(
//                             child: Text('Ok'),
//                             onPressed: () => Navigator.of(context).pop(true),
//                           ),
//                         ],
//                       );
//                     },
//                   ) as FutureOr<bool>);

//                   if (dismiss) {
//                     state!.dismiss();
//                   }
//                 },
//               );
//             } else {
//               return IconSlideAction(
//                 caption: 'Share',
//                 color: renderingMode == SlidableRenderingMode.slide
//                     ? Colors.indigo.withOpacity(animation!.value)
//                     : Colors.indigo,
//                 icon: Icons.share,
//                 onTap: () => _showSnackBar(context, 'Share'),
//               );
//             }
//           }),
//       secondaryActionDelegate: SlideActionBuilderDelegate(
//           actionCount: 2,
//           builder: (context, index, animation, renderingMode) {
//             if (index == 0) {
//               return IconSlideAction(
//                 caption: 'More',
//                 color: renderingMode == SlidableRenderingMode.slide
//                     ? Colors.grey.shade200.withOpacity(animation!.value)
//                     : Colors.grey.shade200,
//                 icon: Icons.more_horiz,
//                 onTap: () => _showSnackBar(context, 'More'),
//                 closeOnTap: false,
//               );
//             } else {
//               return IconSlideAction(
//                 caption: 'Delete',
//                 color: renderingMode == SlidableRenderingMode.slide
//                     ? Colors.red.withOpacity(animation!.value)
//                     : Colors.red,
//                 icon: Icons.delete,
//                 onTap: () => _showSnackBar(context, 'Delete'),
//               );
//             }
//           }),
//     );
//   }

//   static Widget? _getActionPane(int index) {
//     switch (index % 4) {
//       case 0:
//         return SlidableBehindActionPane();
//       case 1:
//         return SlidableStrechActionPane();
//       case 2:
//         return SlidableScrollActionPane();
//       case 3:
//         return SlidableDrawerActionPane();
//       default:
//         return null;
//     }
//   }

//   static Color? _getAvatarColor(int index) {
//     switch (index % 4) {
//       case 0:
//         return Colors.red;
//       case 1:
//         return Colors.green;
//       case 2:
//         return Colors.blue;
//       case 3:
//         return Colors.indigoAccent;
//       default:
//         return null;
//     }
//   }

//   static String? _getSubtitle(int index) {
//     switch (index % 4) {
//       case 0:
//         return 'SlidableBehindActionPane';
//       case 1:
//         return 'SlidableStrechActionPane';
//       case 2:
//         return 'SlidableScrollActionPane';
//       case 3:
//         return 'SlidableDrawerActionPane';
//       default:
//         return null;
//     }
//   }

//   void _showSnackBar(BuildContext context, String text) {
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(SnackBar(content: Text(text)));
//   }
// }

// class HorizontalListItem extends StatelessWidget {
//   HorizontalListItem(this.item);
//   final _HomeItem item;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: 160.0,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Expanded(
//             child: CircleAvatar(
//               backgroundColor: item.color,
//               child: Text('${item.index}'),
//               foregroundColor: Colors.white,
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 item.subtitle!,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class VerticalListItem extends StatelessWidget {
//   VerticalListItem(this.item);
//   final _HomeItem item;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () =>
//           Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
//               ? Slidable.of(context)?.open()
//               : Slidable.of(context)?.close(),
//       child: Container(
//         color: Colors.white,
//         child: ListTile(
//           leading: CircleAvatar(
//             backgroundColor: item.color,
//             child: Text('${item.index}'),
//             foregroundColor: Colors.white,
//           ),
//           title: Text(item.title),
//           subtitle: Text(item.subtitle!),
//         ),
//       ),
//     );
//   }
// }

// class _HomeItem {
//   const _HomeItem(
//     this.index,
//     this.title,
//     this.subtitle,
//     this.color,
//   );

//   final int index;
//   final String title;
//   final String? subtitle;
//   final Color? color;
// }
