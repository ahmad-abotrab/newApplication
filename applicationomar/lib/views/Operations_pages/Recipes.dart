import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import '/Api/Controller/Recipes.dart';

import '/models/Warehouse/Order.dart';
import '/models/Warehouse/product.dart';

class RefillScreen extends StatefulWidget {
  @override
  _Refillviewstate createState() => _Refillviewstate();
}

class _Refillviewstate extends State<RefillScreen> {
  int total = 0;
  FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  List<Order> orderslist;

  final websnackBar = SnackBar(content: Text('You are using Web Version !'));

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          DemoLocalizations.of(context)
              .translate('Operations', 'Recipes', key3: 'appBarTitle'),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          GetBuilder<RecipesController>(
              init: RecipesController(),
              builder: (_) {
                return CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        if (Get.find<RecipesController>().showSubCategory &&
                            (RecipesController.subCategoryItem == null ||
                                RecipesController.subCategoryItem == '')) {
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
                          if (RecipesController.product == null) {
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
                            if (int.parse(
                                    Get.find<RecipesController>().qty.text) >=
                                RecipesController.product.minAmount) {
                            } else {}
                            //here update counter num of product
                            Get.find<RecipesController>().updateCounter();
                            //here know how many quantity chosen from  product
                            RecipesController.product.chosenQuantity =
                                int.parse(
                                    Get.find<RecipesController>().qty.text);
                            //here get price this product
                            RecipesController.product.price = double.parse(
                                Get.find<RecipesController>().price.text);
                            //here add chosen product and added it to List view
                            Get.find<RecipesController>()
                                .updateToRowsList(RecipesController.product);

                            RecipesController.categoryItem = null;
                            RecipesController.subCategoryItem = null;
                            Get.find<RecipesController>().qty =
                                new TextEditingController();
                            RecipesController.product = null;
                            Get.find<RecipesController>().subCategory = [];
                            Get.find<RecipesController>().price =
                                new TextEditingController();
                          }
                        }
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                );
              }),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.camera_alt_sharp, color: Colors.white)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                GetBuilder<RecipesController>(
                    init: RecipesController(),
                    builder: (_) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                                child: DropdownButton<String>(
                                  elevation: 5,
                                  iconSize: 25,
                                  // itemHeight: 1,
                                  borderRadius: BorderRadius.circular(28),
                                  dropdownColor:
                                      Theme.of(context).backgroundColor,
                                  value: RecipesController.categoryItem,
                                  hint: Text(
                                    RecipesController.categoryItem == null
                                        ? DemoLocalizations.of(context)
                                            .translate('Operations', 'Recipes',
                                                key3: 'nameCategory')
                                        : RecipesController.categoryItem,
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),

                                  items: Get.find<RecipesController>()
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
                                    Get.find<RecipesController>()
                                        .updateCategoryItem(item);
                                    Get.find<RecipesController>()
                                        .updateListProduct();
                                  },
                                ),
                              ),
                              Expanded(child: Container()),
                              Get.find<RecipesController>().showSubCategory
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                      child: DropdownButton<String>(
                                        borderRadius: BorderRadius.circular(28),
                                        dropdownColor:
                                            Theme.of(context).backgroundColor,
                                        elevation: 5,
                                        iconSize: 25,
                                        hint: Text(
                                          RecipesController.subCategoryItem ==
                                                  null
                                              ? DemoLocalizations.of(context)
                                                  .translate(
                                                      'Operations', 'Recipes',
                                                      key3: 'nameSubCategory')
                                              : RecipesController
                                                  .subCategoryItem,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: Get.find<RecipesController>()
                                            .subCategory
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (item) {
                                          Get.find<RecipesController>()
                                              .updateSubCategoryItem(item);
                                          Get.find<RecipesController>()
                                              .updateListProduct();
                                        },
                                      ),
                                    )
                                  : Expanded(child: Container()),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04),
                            child: DropdownButton<Product>(
                              borderRadius: BorderRadius.circular(28),
                              dropdownColor: Theme.of(context).backgroundColor,
                              elevation: 5,
                              iconSize: 25,
                              value: RecipesController.product,
                              hint: Text(
                                RecipesController.product == null
                                    ? DemoLocalizations.of(context).translate(
                                        'Operations', 'Recipes',
                                        key3: 'nameProduct')
                                    : RecipesController.product.name,
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                              items: RecipesController.products.map((value) {
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
                                Get.find<RecipesController>()
                                    .updateProduct(value);
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                GetBuilder<RecipesController>(
                    init: RecipesController(),
                    builder: (_) {
                      return Form(
                        key: formKey,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.045),
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: TextFormField(
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                controller: Get.find<RecipesController>().qty,
                                validator: (input) => input.isEmpty
                                    ? DemoLocalizations.of(context).translate(
                                        'Operations', 'Recipes',
                                        key3: 'validatorQTY')
                                    : null,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    hintText: DemoLocalizations.of(context)
                                        .translate('Operations', 'Recipes',
                                            key3: 'qty'),
                                    hintStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                            ),
                            Flexible(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (input) => input.isEmpty
                                    ? DemoLocalizations.of(context).translate(
                                        'Operations', 'Recipes',
                                        key3: 'validatorPrice')
                                    : null,
                                controller: Get.find<RecipesController>().price,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    hintText: DemoLocalizations.of(context)
                                        .translate('Operations', 'Recipes',
                                            key3: 'price'),
                                    hintStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w600),
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                GetBuilder<RecipesController>(
                    init: RecipesController(),
                    builder: (_) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height -
                              MediaQuery.of(context).size.height * 0.48,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor
                              //border: Border.all(color: Colors.black)),
                              ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: RecipesController.rows.length == 0
                                      ? 1
                                      : RecipesController.rows.length,
                                  itemBuilder: (_, int index) {
                                    if (RecipesController.rows.length == 0 ||
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
                                                      'Operations', 'Recipes',
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
                                                      'Operations', 'Recipes',
                                                      key3: 'nameProduct'),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                            ),
                                            trailing: Text(
                                              DemoLocalizations.of(context)
                                                  .translate(
                                                      'Operations', 'Recipes',
                                                      key3: 'totalPrice'),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Divider(thickness: 2),
                                        ],
                                      );
                                    } else {
                                      return Dismissible(
                                        key: UniqueKey(),
                                        direction: DismissDirection.endToStart,

                                        // Remove this product from the list
                                        // In production enviroment, you may want to send some request to delete it on server side
                                        onDismissed: (_) {
                                          RecipesController
                                              .removeItemFormRowsList(index);
                                          Get.find<RecipesController>()
                                              .updateMinusCounter();
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: ListTile(
                                          // isThreeLine: true,
                                          leading: Text(
                                            RecipesController
                                                .rows[index].chosenQuantity
                                                .toString(),
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),

                                          title: Text(
                                            RecipesController.rows[index].name
                                                .toString(),
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          trailing: Text(
                                            RecipesController.rows[index].price
                                                .toString(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .hintColor !=
                                                        Colors.white
                                                    ? Colors.green
                                                    : Theme.of(context)
                                                        .hintColor,
                                                fontWeight: FontWeight.w600),
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
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).hintColor == Colors.white
              ? Colors.blue
              : Colors.grey,
          onPressed: () {},
          child: Icon(Icons.add)),
    );
  }
}
