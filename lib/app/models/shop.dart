class ShopModel {
  String? sId;
  String? title;
  int? status;
  String? pic;
  String? url;

  ShopModel.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    title = json["title"];
    status = json["status"];
    pic = json["pic"];
    url = json["url"];
  }
}
