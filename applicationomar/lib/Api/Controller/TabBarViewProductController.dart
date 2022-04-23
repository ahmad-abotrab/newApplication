import 'package:get/get.dart';
import '/Api/fetchData.dart';
import '/models/Warehouse/product.dart';

class TabBarViewProductController extends GetxController {
  int index;
  bool allProduct;
  bool mostPopular;
  List<Product> products;

  @override
  void onInit() {
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
}
