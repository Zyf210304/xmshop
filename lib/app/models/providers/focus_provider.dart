import 'package:get/get.dart';

import '../focus_model.dart';

class FocusProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return FocusModel.fromJson(map);
      if (map is List) return map.map((item) => FocusModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<FocusModel?> getFocus(int id) async {
    final response = await get('focus/$id');
    return response.body;
  }

  Future<Response<FocusModel>> postFocus(FocusModel focus) async =>
      await post('focus', focus);
  Future<Response> deleteFocus(int id) async => await delete('focus/$id');
}
