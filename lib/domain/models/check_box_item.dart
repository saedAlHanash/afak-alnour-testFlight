import 'package:get/get.dart';

class CheckBoxItemGet {
  RxString title;
  RxString apiName;
  RxBool value;

  CheckBoxItemGet({required this.title,required this.apiName,required this.value});
}

class CheckBoxItem {
  String title;
  String apiName;
  bool? value;


  CheckBoxItem({required this.title,required this.apiName, this.value = false});
}