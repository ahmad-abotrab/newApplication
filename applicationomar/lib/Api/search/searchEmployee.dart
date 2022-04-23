import '/models/Human/Employee.dart';

import '../fetchData.dart';

class SearchEmployee{
    List<Employee> generate(query) {
    List<Employee> listCustomer = FetchData().getEmployeeList();
    return listCustomer.where((customer) {
      final nameLower = customer.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }
}