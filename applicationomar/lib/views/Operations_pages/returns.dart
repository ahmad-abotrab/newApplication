import 'dart:async';

import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/Api/Controller/ReturnsController.dart';
import '/models/Warehouse/product.dart';

class Returns extends StatelessWidget {
  Returns({Key key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
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
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                Text(
                  DemoLocalizations.of(context)
                      .translate('Operations', 'Returns', key3: 'return_title'),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                GetBuilder<ReturnsController>(
                    init: ReturnsController(),
                    builder: (_) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.06),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(28),
                                  dropdownColor:
                                      Theme.of(context).backgroundColor,
                                  elevation: 5,
                                  iconSize:
                                      MediaQuery.of(context).size.width * 0.07,
                                  // itemHeight: 1,

                                  value: ReturnsController.categoryItem,
                                  hint: Text(
                                    ReturnsController.categoryItem == null
                                        ? DemoLocalizations.of(context)
                                            .translate('Operations', 'Returns',
                                                key3: 'category')
                                        : ReturnsController.categoryItem,
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),

                                  items: Get.find<ReturnsController>()
                                      .category
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (item) {
                                    Get.find<ReturnsController>()
                                        .updateCategoryItem(item);
                                    Get.find<ReturnsController>()
                                        .updateListProduct();
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.06),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(28),
                                  dropdownColor:
                                      Theme.of(context).backgroundColor,
                                  elevation: 5,
                                  iconSize:
                                      MediaQuery.of(context).size.width * 0.07,
                                  hint: Text(
                                    ReturnsController.subCategoryItem == null
                                        ? DemoLocalizations.of(context)
                                            .translate('Operations', 'Returns',
                                                key3: 'subCategory')
                                        : ReturnsController.subCategoryItem,
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),
                                  items: Get.find<ReturnsController>()
                                      .subCategory
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (item) {
                                    Get.find<ReturnsController>()
                                        .updateSubCategoryItem(item);
                                    Get.find<ReturnsController>()
                                        .updateListProduct();
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.06),
                                child: DropdownButton<Product>(
                                  borderRadius: BorderRadius.circular(28),
                                  dropdownColor:
                                      Theme.of(context).backgroundColor,
                                  elevation: 5,
                                  iconSize:
                                      MediaQuery.of(context).size.width * 0.07,
                                  value: ReturnsController.product,
                                  hint: Text(
                                    ReturnsController.product == null
                                        ? DemoLocalizations.of(context)
                                            .translate('Operations', 'Returns',
                                                key3: 'productName')
                                        : ReturnsController.product.name,
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),
                                  items: Get.find<ReturnsController>()
                                      .products
                                      .map((value) {
                                    return DropdownMenuItem<Product>(
                                      value: value,
                                      child: Text(
                                        value.name,
                                        style: TextStyle(
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    Get.find<ReturnsController>()
                                        .updateProduct(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                GetBuilder<ReturnsController>(
                    init: ReturnsController(),
                    builder: (_) {
                      return Form(
                        key: formKey,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.045),
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                                keyboardType: TextInputType.number,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.digitsOnly
                                // ],
                                validator: (value) => value.isEmpty ||
                                        value == null
                                    ? DemoLocalizations.of(context).translate(
                                        'Operations', 'Returns',
                                        key3: 'validatorQTY')
                                    : value.isAlphabetOnly
                                        ? DemoLocalizations.of(context)
                                            .translate('Operations', 'Returns',
                                                key3: 'validatorQTYInput')
                                        : null,
                                controller: Get.find<ReturnsController>().qty,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    hintText: DemoLocalizations.of(context)
                                        .translate('Operations', 'Returns',
                                            key3: 'qty'),
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                                validator: (value) =>
                                    value.isEmpty || value == null
                                        ? DemoLocalizations.of(context)
                                            .translate('Operations', 'Returns',
                                                key3: 'validatorPrice')
                                        : null,
                                controller: Get.find<ReturnsController>().price,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    hintText: DemoLocalizations.of(context)
                                        .translate('Operations', 'Returns',
                                            key3: 'price'),
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.02,
                      left: MediaQuery.of(context).size.width * 0.55),
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).hintColor == Colors.white
                        ? Colors.blue
                        : Colors.grey,
                    child: Text(
                      DemoLocalizations.of(context).translate(
                          'Operations', 'Returns',
                          key3: 'returnButton'),
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        if ((ReturnsController.categoryItem == null ||
                                ReturnsController.categoryItem == '') ||
                            (ReturnsController.subCategoryItem == null ||
                                ReturnsController.subCategoryItem == '') ||
                            (ReturnsController.product == null)) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(DemoLocalizations.of(context)
                                        .translate('Operations', 'Returns',
                                            key3: 'dialogValidator',
                                            key4: "Title")),
                                    content: Text(DemoLocalizations.of(context)
                                        .translate('Operations', 'Returns',
                                            key3: 'dialogValidator',
                                            key4: "content")),
                                    actions: [
                                      MaterialButton(
                                          child: Text(
                                              DemoLocalizations.of(context)
                                                  .translate(
                                                      'Operations', 'Returns',
                                                      key3: 'dialogValidator',
                                                      key4: "backBtn")),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  ));
                        } else {
                          showToast(context: context);
                          //Bill bill = new Bill(value: )
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  static void showToast({
    @required BuildContext context,
  }) async {
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
            Text(DemoLocalizations.of(context)
                .translate('Operations', 'Income', key3: 'toast'))
          ],
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
    await Timer(Duration(seconds: 1), () {
      overlayEntry.remove();
      Navigator.pop(context);
    });
  }
}
