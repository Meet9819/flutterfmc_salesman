
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
class SalesOrderData {
  final String order_item_id;
  final String order_id;
  final String itemcode;
  final String order_item_quantity;
  final String foc;
  final String extrabonus;
  final String order_date;
  SalesOrderData({this.order_item_id, this.order_id, this.itemcode,this.order_item_quantity, this.foc, this.extrabonus,this.order_date});

  factory SalesOrderData.fromJson(Map<String, dynamic> json) {
    return SalesOrderData(
      order_item_id: json['order_item_id'],
      order_id: json['order_id'],
      itemcode: json['itemcode'],
      order_item_quantity: json['order_item_quantity'],
      foc: json['foc'],
      extrabonus: json['extrabonus'],
      order_date:json['order_date'],
    );
  }
}

class Salesorder extends StatefulWidget {
  final itemid;
  Salesorder({Key key, @required this.itemid}) : super(key: key);
  @override
  _SalesorderState createState() => _SalesorderState();
}

class _SalesorderState extends State<Salesorder> {
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart_>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Sales Order History"),),
        body:SingleChildScrollView(
            child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             /* PaginatedDataTable(
                header: Text('Header Text'),
                rowsPerPage: 4,
                columns: [
                  DataColumn(label: Text('Header A')),
                  DataColumn(label: Text('Header B')),
                  DataColumn(label: Text('Header C')),
                  DataColumn(label: Text('Header D')),
                ],
               source: _DataSource(context),
              ),
       Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Item id')),
                  DataColumn(label: Text('Order id')),
                  DataColumn(label: Text('Item Code')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Foc')),
                  DataColumn(label: Text('ExtraBonus')),
                ]
            )
        ),*/
        FutureBuilder<List<SalesOrderData>>(
          future: _fetchSalesOrderData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<SalesOrderData> data = snapshot.data;
             // return tableview(context, data);
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:DataTable(
                  columns: [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Item id')),
                    DataColumn(label: Text('Order id')),
                    DataColumn(label: Text('Item Code')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Foc')),
                    DataColumn(label: Text('ExtraBonus')),
                  ],
                  rows:data.map((data) =>
                    DataRow(
                        cells: [
                      DataCell(Text(data.order_date)),
                      DataCell(Text(data.order_item_id)),
                      DataCell(Text(data.order_id)),
                      DataCell(Text(data.itemcode)),
                      DataCell(Text(data.order_item_quantity)),
                      DataCell(Text(data.foc)),
                      DataCell(Text(data.extrabonus)),
                    ]
                   )
                  ).toList(),

                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      LightColor.blueColor),
                ));
          },
        ),

      ]  )

    ));
  }

  Future<List<SalesOrderData>> _fetchSalesOrderData() async {
    var data = {'itemid': widget.itemid};

    var jobsListAPIUrl =
        'http://sharegiants.in/ruchi/salesorder_item.php';
    var response = await http.post(jobsListAPIUrl,  body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new SalesOrderData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
  tableview(context,data){
    return SingleChildScrollView(
      child:DataTable(
        columns: [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Item id')),
          DataColumn(label: Text('Order id')),
          DataColumn(label: Text('Item Code')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Foc')),
          DataColumn(label: Text('ExtraBonus')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(data.order_date)),
            DataCell(Text(data.order_item_id)),
            DataCell(Text(data.order_id)),
            DataCell(Text(data.itemcode)),
            DataCell(Text(data.order_item_quantity)),
            DataCell(Text(data.foc)),
            DataCell(Text(data.extrabonus)),
          ])
        ],
      ),
    );
  }

 /* tableview(context, data) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              // var finalprice = data[index].price;
              return InkWell(
                onTap: () {

                  // Navigator.of(context).pop();
                  //  _fetchSalesOrderData();
                },
                // var finalprice = data[index].price;

                child: SingleChildScrollView(child:
                Column(
                  children: <Widget>[
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(

                              children: <Widget>[
                                Text(
                                  data[index].order_date,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.blueColor),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  data[index].order_item_id,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.blueColor),
                                ),  SizedBox(width: 5,),
                                Text(
                                  data[index].order_id,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.blueColor),
                                ),  SizedBox(width: 5,),
                                Text(
                                  data[index].itemcode,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.blueColor),
                                ),  SizedBox(width: 5,),
                                Text(
                                  data[index].order_item_quantity,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.blueColor),
                                ),  SizedBox(width: 5,),
                                Text(
                                  data[index].foc,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.blueColor),
                                ),  SizedBox(width: 5,),
                                Text(
                                  data[index].extrabonus,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.blueColor),
                                ),  SizedBox(width: 5,),
                              ]),
                        ))
                  ],
                )),
              );
            }));
  }*/
}
class _Row {
_Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    );

final String valueA;
final String valueB;
final String valueC;
final int valueD;

bool selected = false;
}
class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('Cell A1', 'CellB1', 'CellC1', 1),
      _Row('Cell A2', 'CellB2', 'CellC2', 2),
      _Row('Cell A3', 'CellB3', 'CellC3', 3),
      _Row('Cell A4', 'CellB4', 'CellC4', 4),
    ];
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
        index: index,
        selected: row.selected,
        onSelectChanged: (value) {
      if (row.selected != value) {
        _selectedCount += value ? 1 : -1;
        assert(_selectedCount >= 0);
        row.selected = value;
        notifyListeners();
      }
    },
    cells: [
      DataCell(Text(row.valueA)),
      DataCell(Text(row.valueB)),
      DataCell(Text(row.valueC)),
      DataCell(Text(row.valueD.toString())),
    ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
