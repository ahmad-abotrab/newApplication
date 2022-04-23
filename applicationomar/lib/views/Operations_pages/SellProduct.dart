import 'package:applicationomar/localization/localizationFile.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import '/Api/Controller/salesProductsController.dart';
import '/Api/PdfApi.dart';
import '/Api/PdfBillApi.dart';
import '/Api/search/searchCustomer.dart';
import '/models/Human/Customer.dart';

import '/models/Operations/Sell.dart';
import '/models/Operations/SellUp.dart';

import '/models/Warehouse/product.dart';

class SallingProducts extends StatelessWidget {
  SallingProducts({Key key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white)),
        title: GetBuilder<SalesProductsController>(
          init: SalesProductsController(),
          builder: (_) {
            return TypeAheadField(
              // hideSuggestionsOnKeyboardHide: false,
              textFieldConfiguration: TextFieldConfiguration(
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                  controller:
                      Get.find<SalesProductsController>().textEditingController,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'Search_hintText'),
                  )),
              suggestionsCallback: SearchCustomer().generate,
              itemBuilder: (context, suggestion) {
                final user = suggestion;
                return ListTile(
                  title: Text(user.name),
                );
              },
              onSuggestionSelected: (suggestion) {
                Get.find<SalesProductsController>()
                    .updateTextEditingController(suggestion.name);
              },
              // ignore: missing_return
              noItemsFoundBuilder: (context) {
                return Center(
                  child: FittedBox(
                    child: Text(
                       DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'notFound'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            );
          },
        ),
        actions: [
          GetBuilder<SalesProductsController>(
              init: SalesProductsController(),
              builder: (_) {
                return CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        if (Get.find<SalesProductsController>()
                                .showSubCategory &&
                            (SalesProductsController.subCategoryItem == null ||
                                SalesProductsController.subCategoryItem ==
                                    '')) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        ),
                                        Icon(Icons.warning,
                                            color: Colors.yellow),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                        Text(
                                          DemoLocalizations.of(context)
                                              .translate('Operations',
                                                  'SellingProduct',
                                                  key3: 'warning'),
                                        ),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child:
                                          Text(
                                        DemoLocalizations.of(context).translate(
                                            'Operations', 'SellingProduct',
                                            key3: 'warningSubCategoryChose'),
                                      ),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          DemoLocalizations.of(context)
                                              .translate('Operations',
                                                  'SellingProduct',
                                                  key3: 'backButton'),
                                        ),
                                      )
                                    ],
                                  ));
                        } else {
                          if (SalesProductsController.product == null) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          Icon(Icons.warning,
                                              color: Colors.yellow),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                          ),
                                          Text(
                                            DemoLocalizations.of(context)
                                                .translate('Operations',
                                                    'SellingProduct',
                                                    key3: 'warning'),
                                          ),
                                        ],
                                      ),
                                      content: SingleChildScrollView(
                                        child: Text(
                                          DemoLocalizations.of(context)
                                              .translate('Operations',
                                                  'SellingProduct',
                                                  key3: 'warningProductChose'),
                                        ),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            DemoLocalizations.of(context)
                                                .translate('Operations',
                                                    'SellingProduct',
                                                    key3: 'backButton'),
                                          ),
                                        )
                                      ],
                                    ));
                          } else {
                            if (int.parse(Get.find<SalesProductsController>()
                                    .qty
                                    .text) >=
                                SalesProductsController.product.minAmount) {
                            } else {}
                            //here update counter num of product
                            Get.find<SalesProductsController>().updateCounter();
                            //here know how many quantity chosen from  product
                            SalesProductsController.product.chosenQuantity =
                                int.parse(Get.find<SalesProductsController>()
                                    .qty
                                    .text);
                            //here get price this product
                            SalesProductsController.product.price =
                                double.parse(Get.find<SalesProductsController>()
                                    .price
                                    .text);
                            //here add chosen product and added it to List view
                            Get.find<SalesProductsController>()
                                .updateToRowsList(
                                    SalesProductsController.product);
                            SellUp sellup = new SellUp(
                                idProduct: SalesProductsController.product.id,
                                nameProduct:
                                    SalesProductsController.product.name,
                                unitPrice: double.parse(
                                    Get.find<SalesProductsController>()
                                        .price
                                        .text),
                                quantity: int.parse(
                                    Get.find<SalesProductsController>()
                                        .qty
                                        .text));

                            Get.find<SalesProductsController>()
                                .updateSellUp(sellup);
                            SalesProductsController.categoryItem = null;
                            SalesProductsController.subCategoryItem = null;
                            Get.find<SalesProductsController>().qty =
                                new TextEditingController();
                            SalesProductsController.product = null;
                            Get.find<SalesProductsController>().subCategory =
                                [];
                            Get.find<SalesProductsController>().price =
                                new TextEditingController();
                          }
                        }
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                );
              }),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GetBuilder<SalesProductsController>(
                  init: SalesProductsController(),
                  builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.04),
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(28),
                                // isDense: true,
                                elevation: 5,
                                iconSize: 25,
                                // itemHeight: 1,
                                dropdownColor:
                                    Theme.of(context).toggleableActiveColor,

                                value: SalesProductsController.categoryItem,
                                hint: Text(
                                  SalesProductsController.categoryItem == null
                                      ? DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'nameCategory')
                                      : SalesProductsController.categoryItem,
                                  style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),

                                items: Get.find<SalesProductsController>()
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
                                  Get.find<SalesProductsController>()
                                      .updateCategoryItem(item);
                                  Get.find<SalesProductsController>()
                                      .updateListProduct();
                                },
                              ),
                            ),
                            Expanded(child: Container()),
                            Get.find<SalesProductsController>().showSubCategory
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: DropdownButton<String>(
                                      elevation: 5,
                                      iconSize: 25,
                                      dropdownColor: Theme.of(context)
                                          .toggleableActiveColor,
                                      hint: Text(
                                        SalesProductsController
                                                    .subCategoryItem ==
                                                null
                                            ? DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'nameSubCategory')
                                            : SalesProductsController
                                                .subCategoryItem,
                                        style: TextStyle(
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                        ),
                                      ),
                                      items: Get.find<SalesProductsController>()
                                          .subCategory
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .hintColor),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (item) {
                                        Get.find<SalesProductsController>()
                                            .updateSubCategoryItem(item);
                                        Get.find<SalesProductsController>()
                                            .updateListProduct();
                                      },
                                    ),
                                  )
                                : Expanded(child: Container())
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.04),
                          child: DropdownButton<Product>(
                            elevation: 5,
                            iconSize: 25,
                            dropdownColor:
                                Theme.of(context).toggleableActiveColor,
                            value: SalesProductsController.product,
                            hint: Text(
                              SalesProductsController.product == null
                                  ? DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'nameProduct')
                                  : SalesProductsController.product.name,
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            items: Get.find<SalesProductsController>()
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
                              Get.find<SalesProductsController>()
                                  .updateProduct(value);
                            },
                          ),
                        ),
                      ],
                    );
                  }),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              GetBuilder(
                  init: SalesProductsController(),
                  builder: (_) {
                    return Form(
                      key: formKey,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.width * 0.045),
                            width: MediaQuery.of(context).size.width * 0.38,
                            child: TextFormField(
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                              validator: (value) =>
                                  value.isEmpty || value == null
                                      ? DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'validatorQTY')
                                      : null,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller:
                                  Get.find<SalesProductsController>().qty,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: DemoLocalizations.of(context)
                                      .translate('Operations', 'SellingProduct',
                                          key3: 'qty'),
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                          Flexible(
                            child: TextFormField(
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  value.isEmpty || value == null
                                      ? DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'validatorPrice')
                                      : null,
                              controller:
                                  Get.find<SalesProductsController>().price,
                              decoration: InputDecoration(
                                  hintText: DemoLocalizations.of(context)
                                      .translate('Operations', 'SellingProduct',
                                          key3: 'price'),
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
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
              GetBuilder<SalesProductsController>(
                  init: SalesProductsController(),
                  builder: (_) {
                    return Container(
                        // margin: EdgeInsets.only(
                        //     left: MediaQuery.of(context).size.width * 0.025),
                        width: double.infinity,
                        // width: MediaQuery.of(context).size.width -
                        //     MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.height * 0.61,
                        decoration: BoxDecoration(
                          color: Theme.of(context).toggleableActiveColor,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: Get.find<SalesProductsController>()
                                            .rows
                                            .length ==
                                        0
                                    ? 1
                                    : Get.find<SalesProductsController>()
                                        .rows
                                        .length,
                                itemBuilder: (_, int index) {
                                  if (Get.find<SalesProductsController>()
                                              .rows
                                              .length ==
                                          0 ||
                                      index == 0) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          dense: true,
                                          visualDensity:
                                              VisualDensity.comfortable,
                                          enableFeedback: true,
                                          // isThreeLine: true,
                                          leading: Text(
                                            DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'qty'),
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),

                                          title: Text(
                                            DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'SellingProduct',
                                                    key3: 'nameProduct'),
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15),
                                          ),
                                          trailing: Text(
                                           DemoLocalizations.of(context).translate('Operations', 'SellingProduct',key3:'totalPrice'),
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Divider(thickness: 2),
                                      ],
                                    );
                                  } else {
                                    return Dismissible(
                                      key: UniqueKey(),
                                      // direction: DismissDirection.endToStart,

                                      // Remove this product from the list
                                      // In production enviroment, you may want to send some request to delete it on server side
                                      onDismissed: (direction) {
                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          onDismissedEndToStartDirection(
                                              index, context);
                                        } else {
                                          onDismissesStartToEndDirection(
                                              index, context);
                                        }
                                      },

                                      background: backgroundDismissable(),
                                      secondaryBackground:
                                          secondaryBackGroundDismissable(),
                                      child: ListTile(
                                        // isThreeLine: true,
                                        leading: Text(
                                          Get.find<SalesProductsController>()
                                              .rows[index]
                                              .chosenQuantity
                                              .toString(),
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontWeight: FontWeight.w700),
                                        ),

                                        title: Text(
                                          Get.find<SalesProductsController>()
                                              .rows[index]
                                              .name
                                              .toString(),
                                          style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        trailing: Text(
                                          (Get.find<SalesProductsController>()
                                                      .rows[index]
                                                      .price *
                                                  Get.find<
                                                          SalesProductsController>()
                                                      .rows[index]
                                                      .chosenQuantity)
                                              .toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                          .hintColor !=
                                                      Colors.white
                                                  ? Colors.green
                                                  : Theme.of(context).hintColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ));
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).hintColor == Colors.white
              ? Colors.blue
              :  Colors.grey,
          onPressed: () async {
            Sell bill = new Sell(
              id: '1212',
              customer: Customer(name: "Ahmad"),
              notes: 'this is bill for by friends',
              date: DateTime.now(),
              type: 'not',
              productsSell: Get.find<SalesProductsController>().sellupProducts,
            );
            final pdfFile = await PdfBilleApi.generate(
                bill, MediaQuery.of(context).size.width * 0.9);
            PdfApi.openFile(pdfFile);
          },
          child: GetBuilder<SalesProductsController>(
              init: SalesProductsController(),
              builder: (_) {
                return Badge(
                  badgeColor: Colors.purple,
                  badgeContent: Text(
                    Get.find<SalesProductsController>().counter.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                    Icons.add_shopping_cart_sharp,
                  ),
                );
              })),
    );
  }

  onDismissedEndToStartDirection(index, context) {
    Product element = Get.find<SalesProductsController>().rows[index];
    Get.find<SalesProductsController>().removeItemFormRowsList(index);
    Get.find<SalesProductsController>().updateMinusCounter();
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
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          children: <TextSpan>[
            TextSpan(
                text: element.name,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          Get.find<SalesProductsController>()
              .insertItemToRowList(index, element);
        },
      ),
    ));
    // Get.find<SalesProductsController>()
    //     .updateCounter();
  }

  onDismissesStartToEndDirection(index, context) {
    Product element = Get.find<SalesProductsController>().rows[index];
    Get.find<SalesProductsController>().removeItemFormRowsList(index);
    Get.find<SalesProductsController>().updateMinusCounter();
    SalesProductsController.categoryItem = element.catagory;
    SalesProductsController.subCategoryItem = element.subCategory;
    SalesProductsController.product = element;
    Get.find<SalesProductsController>().price.text = element.price.toString();
    Get.find<SalesProductsController>().qty.text =
        element.chosenQuantity.toString();
    Get.find<SalesProductsController>().updateQTYTextEditingController(
        Get.find<SalesProductsController>().qty);
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
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          children: <TextSpan>[
            TextSpan(
                text: element.name,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          Get.find<SalesProductsController>()
              .insertItemToRowList(index, element);
          SalesProductsController.categoryItem = null;
          SalesProductsController.subCategoryItem = null;
          Get.find<SalesProductsController>().qty = new TextEditingController();
          SalesProductsController.product = null;
          Get.find<SalesProductsController>().subCategory = [];
          Get.find<SalesProductsController>().price =
              new TextEditingController();
        },
      ),
    ));
    // Get.find<SalesProductsController>()
    //     .updateCounter();
  }

  backgroundDismissable() {
    return Container(
      color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerRight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  secondaryBackGroundDismissable() {
    return Container(
      color: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerRight,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
