import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Constants/api_constants.dart';
import '../../../Services/http_services.dart';
import '../../HomeScreen/Models/home_categories_model.dart';
import 'package:http/http.dart' as http;

class CategoriesViewController extends GetxController{

  bool loading = false;
  List<CategoryModel?> categories = [];

  //
  fetchCategories()async{

    loading = true;
    update();
    try{
      var result = await HttpService.getRequest(ApiConstants().categories);
      if(result is http.Response){
        if(result.statusCode == 200 || result.statusCode==201){
          categories = homeCategoriesModelFromJson(result.body)!.categories!;
        }
      }
    }catch(e){
      if (kDebugMode) {
        print("Home Categories Error-->$e");
      }
    }
    loading = false;
    update();
  }

  //
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

}