import 'package:get/get.dart';
import '/Api/Controller/DebtsController.dart';
import '/Api/fetchData.dart';
import '/models/Debts/DebtsModel.dart';
import '/models/Human/Customer.dart';

class SearchCustomer {
  List<Customer> generate(query) {
    List<Debts> debtsList = FetchData.deptsProducts;
    List<Customer> listCustomer = FetchData().getCustomerlist();
    List<Customer> list = listCustomer.where((customer) {
      final nameLower = customer.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
    
    
    return list;
  }
}
