import 'package:applicationomar/localization/localizationFile.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ListCategoryUpdatedController extends GetxController {
  List<String> category;
  List<String> subCategrory;
  String chosenCategoryValue;
  String chosenSubCategoryValue;
  ListCategoryUpdatedController(context){
    category = [
      DemoLocalizations.of(context)
          .translate('Warehouse', 'Add Products', key3: 'add_cat'),
    ];
    subCategrory = [
      DemoLocalizations.of(context)
          .translate('Warehouse', 'Add Products', key3: 'add_subcat'),
    ];
  }

  @override
  void onInit() {
    chosenCategoryValue = '';
    chosenSubCategoryValue = '';

    
    super.onInit();
  }


  setSubCategoryList(value) {
    subCategrory = value;
    update();
  }

  updateCategoryValue(value) {
    this.chosenCategoryValue = value;
    update();
  }

  updateSubCategoryValue(value) {
    this.chosenSubCategoryValue = value;
    update();
  }

  addToCategoryList(int index, String element) {
    category.insert(index, element);
    update();
  }

  addToSubCategoryList(int index, String element) {
    subCategrory.insert(index, element);
    update();
  }

  removeFromCategoryListByIndex(int index) {
    category.removeAt(index);
    update();
  }

  removeFromSubCategoryListByIndex(int index) {
    subCategrory.removeAt(index);
    update();
  }

  removeFromCategoryList(String value) {
    category.remove(value);
    update();
  }

  removeFromSubCategoryList(String value) {
    subCategrory.remove(value);
    update();
  }
}
