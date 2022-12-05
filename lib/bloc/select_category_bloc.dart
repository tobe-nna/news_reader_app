import 'dart:async';

import 'package:text_reader/utils.dart';

class SelectCategoryBloc{
  final StreamController categoryController = StreamController.broadcast();
  Stream get categoryStream => categoryController.stream;

  final StreamController countryController = StreamController.broadcast();
  Stream get countryStream => countryController.stream;

  String defaultCategory = categories[0];
  String defaultCountry = 'ng';

  void selectCategory(String category) {
    categoryController.sink.add(category);
  }

  void selectCountry(dynamic code) {
    countryController.sink.add(code);
  }

  dispose(){
    categoryController.close();
    countryController.close();
  }
}