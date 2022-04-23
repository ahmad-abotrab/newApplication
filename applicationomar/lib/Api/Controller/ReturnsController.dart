import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Api/fetchData.dart';
import '/models/Warehouse/product.dart';

class ReturnsController extends GetxController {
  Map<String, List<String>> categoriesWithSubCategories;
  List<String> category;
  List<String> subCategory;
  List<Product> products;
 
  static String categoryItem;
  static String subCategoryItem;
  static Product product;
  TextEditingController qty;
  TextEditingController price;
 
  bool showSubCategory;

  @override
  void onInit() {
    this.categoriesWithSubCategories =
        FetchData().convertProductsListToMapCategory();
    this.category = categoriesWithSubCategories.keys.toList();
    this.subCategory = [];
    products = [];
    this.qty = new TextEditingController();
    this.price = new TextEditingController();

    

    this.showSubCategory = false;
    super.onInit();
  }

  updatePriceTextEditingController(price) {
    this.price = price;
    update();
  }

  updateQTYTextEditingController(qty) {
    this.qty = qty;
    update();
  }

 

  updateSubCategoryItem(dynamic item) {
    subCategoryItem = item;
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
