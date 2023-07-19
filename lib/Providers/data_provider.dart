import 'package:flutter/material.dart';
import 'package:ipix_mt/Services/data_services.dart';
import 'package:ipix_mt/Models/data_service_model.dart';

class DataProvider with ChangeNotifier {
  Welcome? welcome;
  bool loading = false;

  Future dataProviders({required BuildContext context}) async {
    loading = true;
    welcome = await DataServices.dataServices();
    loading = false;
    notifyListeners();
     return welcome;
  }
}
