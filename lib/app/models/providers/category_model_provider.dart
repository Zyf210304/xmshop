import 'package:get/get.dart';

import '../category_model_model.dart';

class CategoryModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return CategoryModel.fromJson(map);
      if (map is List)
        return map.map((item) => CategoryModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<CategoryModel?> getCategoryModel(int id) async {
    final response = await get('categorymodel/$id');
    return response.body;
  }

  Future<Response<CategoryModel>> postCategoryModel(
          CategoryModel categorymodel) async =>
      await post('categorymodel', categorymodel);
  Future<Response> deleteCategoryModel(int id) async =>
      await delete('categorymodel/$id');
}
