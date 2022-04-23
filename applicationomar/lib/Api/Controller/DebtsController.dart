import 'package:get/get.dart';
import '/Api/fetchData.dart';
import '/models/Debts/DebtsModel.dart';

class DebtsController extends GetxController {
  double getMoney = 0;
  double setMoney = 0;
  String typeOfDebts = '';
  List<Debts> debtsList;
  DateTime selectedDate;
  bool checkedvalue;

  @override
  void onInit() {
    this.debtsList = FetchData.deptsProducts;
    getMoney = 0;
    for (Debts debts in debtsList) {
      getMoney += debts.value;
    }
    setMoney = 0;
    checkedvalue = true;
    super.onInit();
  }

  updateCheckedValue(value) {
    this.checkedvalue = value;
    update();
  }

  updateDate(value) {
    this.selectedDate = value;
    update();
  }

  updateTypeOfDebts(value) {
    this.typeOfDebts = value;
    update();
  }

  updateGetMoney(value) {
    this.getMoney = (this.getMoney - value).abs();
    update();
  }

  updateToListDebts(index, value) {
    this.debtsList[index] = value;
    update();
  }

  setList(list) {
    this.debtsList = list;
    update();
  }
}
