import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Api/fetchData.dart';
import '/models/Operations/SellUp.dart';
import '/models/Warehouse/product.dart';

class SalesProductsController extends GetxController {
  Map<String, List<String>> categoriesWithSubCategories;
  List<String> category;
  List<String> subCategory;
  List<Product> products;
  List<Product> rows;
  List<SellUp> sellupProducts;
  static String categoryItem;
  static String subCategoryItem;
  static Product product;
  TextEditingController qty;
  TextEditingController price;
  int counter;
  bool showSubCategory;
  TextEditingController textEditingController;

  @override
  void onInit() {
    this.textEditingController = new TextEditingController();
    this.categoriesWithSubCategories =
        FetchData().convertProductsListToMapCategory();
    this.category = categoriesWithSubCategories.keys.toList();
    this.subCategory = [];
    products = [];
    this.qty = new TextEditingController();
    this.price = new TextEditingController();
    this.sellupProducts = [];
    rows = [Product()];
    this.counter = 0;
    this.showSubCategory = false;
    super.onInit();
  }

  updateTextEditingController(value) {
    this.textEditingController.text = value;
    update();
  }

  updateSellUp(sellup) {
    this.sellupProducts.add(sellup);
    update();
  }

  updatePriceTextEditingController(price) {
    this.price = price;
    update();
  }

  updateQTYTextEditingController(qty) {
    this.qty = qty;
    update();
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
    this.rows.add(value);
  }

  removeItemFormRowsList(int index) {
    this.rows.removeAt(index);
    update();
  }

  insertItemToRowList(index, element) {
    this.rows.insert(index, element);
    counter++;
    update();
  }

  updateListProduct() {
    List<Product> temp = FetchData().getListProducts();
    product = null;
    if (categoryItem != null) {
      this.products = [];
      for (Product product in temp) {
        if (product.catagory == categoryItem) {
          print(product.name);
          this.products.add(product);
        }
      }

      if (subCategoryItem != null) {
        this.products = [];
        for (Product product in temp) {
          if (product.subCategory == subCategoryItem) {
            this.products.add(product);
          }
        }
      }
    } else {
      this.products = temp;
    }
    update();
  }
}
