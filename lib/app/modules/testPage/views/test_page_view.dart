import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_page_controller.dart';

class TestPageView extends GetView<TestPageController> {

  //type 0 第一个  1 中间的  2 最后一个
  Widget _listCell (String contetnt,{type = 1}) {
    return Container(
      color: Colors.grey[300],
      child: IntrinsicHeight(
        child: Row(
        children: [
          
          Container(
            width: 80,
            height: double.infinity,
            color: Colors.yellow,
            child: Stack( 
              // alignment: Alignment.center,
              children: [ 
                // Text("11"),
              Positioned(
                top: type == 0 ? 15: 0,
                bottom: type == 2 ?  null :  0,
                left: 39,
                child: type == 2 ? Container(color:Colors.red, width: 2, height: 15,) : Container(color:Colors.red, width: 2,)),
              
              Container(
                margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                width: 50,
                height: 50,
                color: Colors.purple,
              )
            
              ],
            )
            ,
          ),


          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(contetnt),
              ))
          
        ],
      ),
      ),
    );
  }
  const TestPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: const Text('TestPageView'),
        centerTitle: true,
      ),
      body: ListView(
        children: [ 
          _listCell("自适应文本", type: 0),
          _listCell("自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本"),
          _listCell("自适应文本自适应文本自适应文本本自适适应文本自适应文本自适应文本自适应文本自适应文本自适适应文本自适应文本自适应文本自适应文本自适应文本自适适应文本自适应文本自适应文本自适应文本自适应文本自适适应文本自适应文本自适应文本自适应文本自适应文本自适适应文本自适应文本自适应文本自适应文本自适应文本自适适应文本自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本自适应文本"),
           _listCell("自适应文本自适应文本自适应文本"),
          _listCell("自适适应文本自适应文本自适应文本适应文本自适应文本自适应文本适应文本自适应文本自适应文本适应文本自适应文本自适应文本适应文本自适应文本自适应文本适应文本自适应文本自适应文本应文本", type: 2),
        ],
      ),
    );
  }
}
