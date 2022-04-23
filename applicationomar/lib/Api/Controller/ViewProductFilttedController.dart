import '/models/Warehouse/product.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../fetchData.dart';

class ViewProductFiltterdController extends GetxController {
  List<String> subCategory;
  static String categoryItem;
  static String subCategoryItem;
  bool showSubCategroy;
  int index;
  bool allProduct;
  bool mostPopular;
  List<Product> products;
  Product product;

  @override
  void onInit() {
    product = new Product();
    categoryItem = null;
    subCategoryItem = null;
    this.showSubCategroy = false;
    this.subCategory = [];
    index = 0;
    allProduct = true;
    mostPopular = false;
    this.products = FetchData().getListProducts();
    super.onInit();
  }

  getElementForProductsList(index) {
    update();
    return this.products[index];
  }

  removeAtIndexFromProducts(int index) {
    this.products.removeAt(index);
    update();
  }

  updateIndex(int index) {
    this.index = index;
    update();
  }

  updateAllProductBoolean(bool value) {
    this.allProduct = value;
    update();
  }

  updateMostPopularBoolean(bool value) {
    this.mostPopular = value;
    update();
  }

  insertNewElementInList(index, element) {
    this.products.insert(index, element);
    update();
  }

  updateValueSubCategory(value) {
    subCategoryItem = value;
    update();
  }

  updateValueCategory(value) {
    categoryItem = value;
    update();
  }

  updateListSubCategory(List<String> subCategory) {
    print('here in class get. ');
    print(this.subCategory);
    //this.subCategory = List<String>.empty()
    subCategoryItem = null;
    this.subCategory = [];
    this.subCategory = subCategory;
    if (this.subCategory.isEmpty ||
        this.subCategory == null ||
        this.subCategory.length == 0) {
      this.showSubCategroy = false;
    } else {
      this.showSubCategroy = true;
    }
    update();
  }

  updateToCreateAllProductsList() {
    this.products = FetchData().getListProducts();
    update();
  }
  

  updateListProduct() {
    List<Product> temp = FetchData().getListProducts();
    product = null;
    if (categoryItem != null) {
      this.products = [Product()];
      for (Product product in temp) {
        if (product.catagory == categoryItem) {
          print(product.name);
          this.products.add(product);
        }
      }

      if (subCategoryItem != null) {
        this.products = [Product()];
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

  getListSubCategory() {
    return subCategory;
  }

  getCategoryItem() {
    return categoryItem;
  }

  getSubCategoryItem() {
    return subCategoryItem;
  }
}
