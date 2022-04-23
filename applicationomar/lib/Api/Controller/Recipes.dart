import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/models/Warehouse/product.dart';

import '../fetchData.dart';

class RecipesController extends GetxController {
  Map<String, List<String>> categoriesWithSubCategories;
  List<String> category;
  List<String> subCategory;
  static List<Product> products;
  static List<Product> rows;
  static String categoryItem;
  static String subCategoryItem;
  static Product product;
  TextEditingController qty;
  TextEditingController price;
  bool showSubCategory;
  int counter;

  @override
  void onInit() {
    this.categoriesWithSubCategories =
        FetchData().convertProductsListToMapCategory();
    this.category = categoriesWithSubCategories.keys.toList();
    this.subCategory = [];
    products = [];
    this.qty = new TextEditingController();
    this.price = new TextEditingController();

    rows = [Product()];
    this.counter = 0;
     this.showSubCategory = false;
    super.onInit();
  }

  updateCounter() {
    this.counter++;
    update();
  }

  updateSubCategoryItem(dynamic item) {
    subCategoryItem = item;
    update();
  }

  updateMinusCounter() {
    this.counter = this.counter - 1;
    update();
  }

    updateCategoryItem(dynamic item) {
    categoryItem = item;
    subCategoryItem = null;
    this.subCategory = [];
    this.subCategory = this.categoriesWithSubCategories[categoryItem];
    if (this.subCategory == null ||
        this.subCategory.length == 0 ||
        this.subCategory.isEmpty) {
      this.showSubCategory = false;
    } else {
      this.showSubCategory = true;
    }
    update();
  }

  updateProduct(value) {
    product = value;
    update();
  }

  updateToRowsList(value) {
    rows.add(value);
  }

  static removeItemFormRowsList(int index) {
    rows.removeAt(index);
  }

  updateListProduct() {
    List<Product> temp = FetchData().getListProducts();
    product = null;
    if (categoryItem != null) {
     products = [];
      for (Product product in temp) {
        if (product.catagory == categoryItem) {
          print(product.name);
         products.add(product);
        }
      }

      if (subCategoryItem != null) {
        products = [];
        for (Product product in temp) {
          if (product.subCategory == subCategoryItem) {
            products.add(product);
          }
        }
      }
    } else {
      products = temp;
    }
    update();
  }
}
