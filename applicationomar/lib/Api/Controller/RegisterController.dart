import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterController extends GetxController {
  String typeOfWork;
  List<String> typeOfWorkList(context) {
    return [
      'محاسب',
      'مدير',
      'موظف',
    ];
  }

  @override
  void onInit() {
 
    super.onInit();
  }

  updateType(value) {
    this.typeOfWork = value;
    update();
  }
}
