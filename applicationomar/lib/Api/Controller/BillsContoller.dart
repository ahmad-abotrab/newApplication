import 'package:applicationomar/localization/localizationFile.dart';
import 'package:get/get.dart';

class BillsController extends GetxController {
  static String chosenvValue;
  static List<String> billsType = [];

  @override
  void onInit() {
    chosenvValue = null;
    super.onInit();
  }

  static List<String> billsitems(context) {
    return [
      DemoLocalizations.of(context)
          .translate('Operations', 'Bills', key3: 'electricity'),
      DemoLocalizations.of(context)
          .translate('Operations', 'Bills', key3: 'water'),
      DemoLocalizations.of(context)
          .translate('Operations', 'Bills', key3: 'phone'),
      DemoLocalizations.of(context)
          .translate('Operations', 'Bills', key3: 'Transport'),
      DemoLocalizations.of(context)
          .translate('Operations', 'Bills', key3: 'gas'),
      DemoLocalizations.of(context)
          .translate('Operations', 'Bills', key3: 'other'),
    ];
  }

  updateChosenValueByDropDown(value) {
    chosenvValue = value;
    update();
  }
}
