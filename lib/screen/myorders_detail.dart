import 'package:flutter/material.dart';
import 'package:fmc_salesman/screen/order_details_item.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:timeline_node/timeline_node.dart';

class myorderdetail extends StatefulWidget {
  final todo;

  myorderdetail({Key key, @required this.todo}) : super(key: key);

  @override
  _myorderdetailState createState() => _myorderdetailState();
}

class HomePageTimelineObject {
  final TimelineNodeStyle style;
  final String message;
  final TextStyle textStyle;
  final String submsg;
  final Icon icon;

  HomePageTimelineObject({this.style, this.message,this.textStyle,this.submsg,this.icon});
}

class _myorderdetailState extends State<myorderdetail> {
  @override
  Widget build(BuildContext context) {

    final List<HomePageTimelineObject> timelineObject = [
      HomePageTimelineObject(
          message: 'Order Received',
          submsg: 'Your order has been Received successfully',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
            // lineType: TimelineNodeLineType.BottomHalf,
            lineType: TimelineNodeLineType.Full,
            lineColor: LightColor.blueColor,
          )),
      HomePageTimelineObject(
          message: 'In Process',
          submsg: 'Your order is In Process',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.Full,
            lineColor: LightColor.blueColor,
          )),
      HomePageTimelineObject(
          message: 'Out for Delivery',
          submsg: 'Your order has been Out for Delivery',
          icon: Icon(Icons.check_circle,color:LightColor.whiteColor ,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
              lineType: TimelineNodeLineType.Full,
              lineColor: LightColor.blueColor)),
      HomePageTimelineObject(
          message: 'Delivered',
          submsg: 'Your order has been Delivered successfully',
          icon: Icon(Icons.hourglass_full,size: 30,),
          style: TimelineNodeStyle(
              lineType: TimelineNodeLineType.Full,
              lineColor: LightColor.whiteColor)),
    ];


    final List<HomePageTimelineObject> timelineObject1 = [
      HomePageTimelineObject(
          message: 'Order Received',
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          submsg: 'Your order has been Received successfully',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.BottomHalf,
            lineColor: LightColor.blueColor,
          )),
      HomePageTimelineObject(
          message: 'In Process',
          submsg: 'Your order is In Process',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.Full,
            lineColor: LightColor.blueColor,
          )),
      HomePageTimelineObject(
          message: 'Out for Delivery',
          submsg: 'Your order has been Out for Delivery',
          icon: Icon(Icons.hourglass_full,size: 30,),
          style: TimelineNodeStyle(
              lineType: TimelineNodeLineType.Full,
              lineColor: LightColor.whiteColor)),
      HomePageTimelineObject(
          message: 'Delivered',
          submsg: 'Your order has been Delivered successfully',
          icon: Icon(Icons.hourglass_full,size: 30,),
          style: TimelineNodeStyle(
              lineType: TimelineNodeLineType.Full,
              lineColor: LightColor.whiteColor)),
    ];



    final List<HomePageTimelineObject> timelineObject2 = [
      // if(widget.todo.ecommerceorderstatus=='SHIPPED - OUT_FOR_DELIVERY')(
      HomePageTimelineObject(
          message: 'Order Received',
          submsg: 'Your order has been Received successfully',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.BottomHalf,
            lineColor: LightColor.blueColor,
          )),
      HomePageTimelineObject(
          message: 'In Process',
          submsg: 'Your order is In Process',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.Full,
            lineColor: LightColor.blueColor,
          )),
      HomePageTimelineObject(
          message: 'Out for Delivery',
          submsg: 'Your order has been Out for Delivery',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
              lineType: TimelineNodeLineType.Full,
              lineColor: LightColor.blueColor)),
      HomePageTimelineObject(
          message: 'Delivered',
          submsg: 'Your order has been Delivered successfully',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
              lineType: TimelineNodeLineType.Full,
              lineColor: LightColor.blueColor)),
    ];



    final List<HomePageTimelineObject> timelineObject3 = [
      // if(widget.todo.ecommerceorderstatus=='SHIPPED - OUT_FOR_DELIVERY')(
      HomePageTimelineObject(
          message: 'Order Received',
          submsg: 'Your order has been Received successfully',
          icon: Icon(Icons.check_circle,color: LightColor.whiteColor,size: 30,),
          textStyle: TextStyle(color: LightColor.whiteColor,fontWeight:FontWeight.bold ) ,
          style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.BottomHalf,
            lineColor: LightColor.blueColor,
          )),
      HomePageTimelineObject(
          message: 'In Process',
          submsg: 'Your order is In Process',
          icon: Icon(Icons.hourglass_full,size: 30,),
          style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.Full,
            lineColor: LightColor.blueColor,
          )),
      HomePageTimelineObject(
          message: 'Out for Delivery',
          submsg: 'Your order has been Out for Delivery',
          icon: Icon(Icons.hourglass_full,size: 30,),
          style: TimelineNodeStyle(
              lineType: TimelineNodeLineType.Full,
              lineColor: LightColor.blueColor)),
      HomePageTimelineObject(
          message: 'Delivered',
          submsg: 'Your order has been Delivered successfully',
          icon: Icon(Icons.hourglass_full,size: 30,),
          style: TimelineNodeStyle(
              lineType: TimelineNodeLineType.Full,
              lineColor: LightColor.blueColor)),
    ];



    return Scaffold(

      // backgroundColor: LightColor.yellowColor,
        appBar: AppBar(
          title: Text('Order Details'),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: Container(
                  child: Column(children: <Widget>[
                    Expanded(
                        child: Container(
                          //padding: EdgeInsets.only(left: 15, right: 15),
                            child: ListView(
                                scrollDirection: Axis.vertical,
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  if(widget.todo.status=='1')(
                                    Center(
                                        child: Chip(
                                          backgroundColor: Colors.green,
                                          label: Text(
                                           'Approved',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: LightColor.whiteColor),
                                          ),)
                                    )
                                  )
                                  else(
                                      Center(
                                          child: Chip(
                                            backgroundColor: Colors.red,
                                            label: Text(
                                              'Not Approved',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: LightColor.whiteColor),
                                            ),)
                                      )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "\ View Order Details",
                                      style:
                                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(120.0),
                                      border: TableBorder.all(
                                          color: Colors.black12,
                                          style: BorderStyle.solid,
                                          width: 2),
                                      children: [

                                        TableRow(children: [
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "\ Document No ",
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ]),
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.todo.whichcompany+'/'+widget.todo.whichbranch+'/'+widget.todo.order_id,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ]),

                                        TableRow(children: [
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "\  Order No ",
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ]),
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.todo.order_id,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ]),
                                        TableRow(children: [
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "\ Order Date ",
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ]),
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.todo.order_date,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ]),
                                        TableRow(children: [
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "\ Amount ",
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ]),
                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.todo.order_total_after_tax,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ]),




                                      ],
                                    ),
                                  ),
                                  Card(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Padding(
                                                padding: EdgeInsets.only(top: 10.0, left: 15.0,right: 10),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        "\ Details",
                                                        style: TextStyle(
                                                          fontSize: 15, ),
                                                      ),SizedBox(height: 10,),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              "\ Customer",
                                                              style: TextStyle(
                                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              widget.todo.name,
                                                              style: TextStyle(
                                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),]),SizedBox(height: 5,),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              "\ Email",
                                                              style: TextStyle(
                                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              widget.todo.customeremail,
                                                              style: TextStyle(
                                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),]),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              "\ Type",
                                                              style: TextStyle(
                                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              widget.todo.customertype,
                                                              style: TextStyle(
                                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),]),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              "\ Employee Name",
                                                              style: TextStyle(
                                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              widget.todo.employeeid,
                                                              style: TextStyle(
                                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),]),
                                                      SizedBox(height: 10,),
                                                    ])))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "View Item Details",
                                      style:
                                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      height: 205,
                                      child: OrderdetailsItemsDemo(id: widget.todo.order_id),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),



                                  SizedBox(height: 20,),
    Card(
    child: Row(
    children: <Widget>[
    Expanded(
    child: Padding(
    padding: EdgeInsets.only(top: 10.0, left: 15.0,right: 10),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text(
    "\ Payment Details",
    style: TextStyle(
    fontSize: 15, ),
    ),SizedBox(height: 10,),
    SizedBox(height: 5,),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Text(
    "\ Total Amount",
    style: TextStyle(
    fontSize: 14, fontWeight: FontWeight.bold),
    ),
    Text(
    "\ QR ${widget.todo.order_total_after_tax}",
    style: TextStyle(
    fontSize: 14, fontWeight: FontWeight.bold),
    ),]),
    SizedBox(height: 10,),
    ])))
    ],
    ),
    ),
                                /*  Container(
                                      constraints: BoxConstraints(
                                        maxHeight:400,
                                      ),
                                      child:
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: timelineObject.length,
                                        itemBuilder: (context, index) {
                                          if (widget.todo.status ==
                                              'SHIPPED - OUT_FOR_DELIVERY') {
                                            return TimelineNode(
                                              style: timelineObject[index].style,
                                              indicator: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Container(
                                                    color: LightColor.yellowColor,
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(4),
                                                child: Card(
                                                  child: Padding(
                                                      padding: EdgeInsets.all(16),

                                                      child:
                                                      Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Text(timelineObject[index].message,style:timelineObject[index].textStyle ,),
                                                                  timelineObject[index].icon,
                                                                ]),
                                                            Text(timelineObject[index].submsg,style:TextStyle(
                                                              fontSize: 10,) ,),
                                                          ] )),
                                                ),
                                              ),
                                            );
                                          } else if (widget.todo.status ==
                                              'IN_PROCESS') {
                                            return TimelineNode(
                                              style: timelineObject1[index].style,
                                              indicator: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Container(
                                                    color: LightColor.yellowColor,
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(4),
                                                child: Card(
                                                  child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child:
                                                      Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Text(timelineObject1[index].message,style:timelineObject1[index].textStyle ,),
                                                                  timelineObject1[index].icon,
                                                                ]),
                                                            Text(timelineObject1[index].submsg,style:TextStyle(
                                                              fontSize: 10,)),
                                                          ] )
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (widget.todo.ecommerceorderstatus ==
                                              'DELIVERED') {
                                            return TimelineNode(
                                              style: timelineObject2[index].style,
                                              indicator: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Container(
                                                    color: LightColor.yellowColor,
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(4),
                                                child: Card(
                                                  child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child:
                                                      Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Text(timelineObject2[index].message,style:timelineObject2[index].textStyle ,),
                                                                  timelineObject2[index].icon,
                                                                ]),
                                                            Text(timelineObject2[index].submsg,style:TextStyle(
                                                              fontSize: 10,)),
                                                          ] )
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return TimelineNode(
                                              style: timelineObject3[index].style,
                                              indicator: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Container(
                                                    color: LightColor.yellowColor,
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(4),
                                                child: Card(
                                                  child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child:
                                                      Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Text(timelineObject3[index].message,style:timelineObject3[index].textStyle ,),
                                                                  timelineObject3[index].icon,
                                                                ]),
                                                            Text(timelineObject3[index].submsg,style:TextStyle(
                                                              fontSize: 10,)),
                                                          ] )
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      )),*/
                                  SizedBox(
                                    height: 10,
                                  ),

                                ]))),

                  ])))
        ]));
  }

}
