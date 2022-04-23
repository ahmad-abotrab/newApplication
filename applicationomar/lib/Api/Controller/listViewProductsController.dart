import 'package:get/get.dart';
import '/Api/fetchData.dart';
import '/models/Warehouse/product.dart';

import 'ViewProductFilttedController.dart';

class ListViewProductController extends GetxController {
  List<Product> products;

  @override
  void onInit() {
    if (ViewProductFiltterdController.categoryItem != null) {
      products = FetchData()
          .getListProducts()
          .where((product) =>
              product == ViewProductFiltterdController.categoryItem)
          .toList();
    } else {
      products = FetchData().getListProducts();
    }
    super.onInit();
  }

  removeAtIndexFromProducts(int index) {
    this.products.removeAt(index);
    update();
  }
}
