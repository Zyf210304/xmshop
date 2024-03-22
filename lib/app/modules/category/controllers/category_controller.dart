import 'package:get/get.dart';
import 'package:xmshop/app/models/category_model_model.dart';
import 'package:dio/dio.dart';


class CategoryController extends GetxController {
  //TODO: Implement CategoryController

  var selectIndex = 0.obs;
  var leftList = <CategoryItemModel>[].obs;
  var rightList = <CategoryItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    //获取左侧一级分类
    getLeftListData();


  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeIndex(index) {
    selectIndex.value = index;
    CategoryItemModel model = leftList[index];
    getRightListData(model.sId);
    update();
  }

   getLeftListData() async {
    var response = await Dio().get("https://miapp.itying.com/api/pcate");
    var list = CategoryModel.fromJson(response.data);
    leftList.value = list.result!;
    getRightListData(leftList[0].sId);
    update();
  }

  getRightListData(pid) async {
    var response = await Dio().get("https://miapp.itying.com/api/pcate?pid=$pid");
    var list = CategoryModel.fromJson(response.data);
    rightList.value = list.result!;
    print("-------$pid");
    print(response);
    print(list.result);
    update();
  }

}
