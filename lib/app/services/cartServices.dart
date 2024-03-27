import "./httpsClient.dart";
import './storage.dart';
import '../models/pcount_model.dart';

class CartServices {
  
  static addCart(PcountItemModel pcontent,  String selectedAttr, int buyNum)  async{

    List? cartListData = await Storage.getData("cartList");
    if(cartListData != null) {
      

      var  hasData = cartListData.any((element) {
        //不仅要判断id  id只是手机型号  也要看用户选的手机配置
        return element["_id"] == pcontent.sId && element["selectedAttr"] == selectedAttr;
      });

      if (hasData) {

         for (var i = 0; i < cartListData.length; i++) {
           if (cartListData[i]["_id"] == pcontent.sId && cartListData[i]["selectedAttr"] == selectedAttr) {
              cartListData[i]["count"] = cartListData[i]["count"] + buyNum;
           } 
         }
        await  Storage.setData("cartList", cartListData);
        print("----补充数据");
      } else {


        cartListData.add(
          {
          "_id":pcontent.sId, 
          "title":pcontent.title,
          "price":pcontent.price,
          "selectedAttr":selectedAttr,
          "count":1,
          "pic":HttpClient.replaceUri(pcontent.pic),
          "checked":true
          }
        );
         await  Storage.setData("cartList", cartListData);
  print("----添加新数据");
      }

    } else {
        List tempList = [];
        tempList.add({
          "_id":pcontent.sId, 
          "title":pcontent.title,
          "price":pcontent.price,
          "selectedAttr":selectedAttr,
          "count":1,
          "pic":HttpClient.replaceUri(pcontent.pic),
          "checked":true
          });
        await  Storage.setData("cartList", tempList);

        print("新建");
    }

  }



  //获取历史搜索记录
  static Future<List> getCartData() async {
    List? listData = await Storage.getData("cartList");
    if (listData != null) {
        return listData;
    } else {
      return [];
    }
  }

  //删除搜索记录
  // static deleteHistoryData(keywords) async {
  //   List? listData = await Storage.getData("searchList");
  //   if (searchListData != null) {
  //     searchListData.remove(keywords);
  //     await Storage.setData("searchList", searchListData);
  //   }
  // }

  //清空搜索记录
  static clearHistoryData() async {
    await Storage.clear("cartList");
  }
  
  //获取选择的数据
  static getCheckedCartData() async {
    var tempList = [];
    List? cartListData = await Storage.getData("cartList");
    if (cartListData != null) {
      for (var i = 0; i < cartListData.length; i++) {
        if (cartListData[i]["checked"] == true) {
          tempList.add(cartListData[i]);
        }
      }
      return tempList;
    } else {
      return [];
    }
    

  }

  static setCartList(cartListData) async {
    await Storage.setData("cartList", cartListData);
  }



}