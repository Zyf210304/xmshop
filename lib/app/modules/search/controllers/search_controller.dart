import 'package:get/get.dart';
import '../../../services/searchServices.dart';

class SearchController1 extends GetxController {
  //TODO: Implement SearchController

  String keywords = "";
  var histroyList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getHistoryList();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getHistoryList() async {
    histroyList.value =  await SearchServices.getHistoryData();
    update();
  }
  
  clearHistoryData() async {
    await SearchServices.clearHistoryData();
    histroyList.clear();
    update();
  }


  deleteHistoryData(keywords) async {
    await SearchServices.deleteHistoryData(keywords);
    histroyList.remove(keywords);
    update();
  }

}
