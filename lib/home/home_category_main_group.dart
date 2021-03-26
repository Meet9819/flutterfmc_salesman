import 'package:fmc_salesman/Item_group_screen/item_group.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';


class ItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          child: ItemDemo(),
        )
    );
  }
}

class Job {
  final String url;
  final String title;
  final String id;
  Job({this.url,this.title,this.id});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id:json['id'],
      url: json['image'],
      title:json['etitle'],
    );
  }
}
class ItemDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> data = snapshot.data;
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.whiteColor),));
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl = 'http://sharegiants.in/ruchi/itemmaingroup.php?action=fetch_all';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
imageSlider(context,data) {
  final width = MediaQuery.of(context).size.width;
  final height=MediaQuery.of(context).size.height;
  final containerh= height/2;
  if (height > 450 && width > 450 && width < 835  ) {
    //samsung tab vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ItemGroup(
                          itemid: data[index].id, itemtitle: data[index].title))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                //  height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFFECEFF1),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network('http://sharegiants.in/ruchi/images/itemmaingroupimages/'+data[index].url,    height: containerh / 2.5,
                      width: width / 2,),
                    Container(
                      height: containerh / 15, width: width / 2,
                      child: Text(
                        data[index].title, textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ),
          );
        }
    );
  }
  else
  if (width > 450 && width < 835) {
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.5),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ItemGroup(
                          itemid: data[index].id, itemtitle: data[index].title))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('http://sharegiants.in/ruchi/images/itemmaingroupimages/'+data[index].url, height: containerh / 1.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 10, width: width / 2,
                        child: Text(
                          data[index].title, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  else
  if (width < 450) {
    //samsung A51 vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.7),
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ItemGroup(
                          itemid: data[index].id, itemtitle: data[index].title))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('http://sharegiants.in/ruchi/images/itemmaingroupimages/'+data[index].url, height: containerh / 3.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 21, width: width / 2,
                        child: Text(
                          data[index].title, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  else {
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.45),
            crossAxisCount: 5),

        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ItemGroup(
                          itemid: data[index].id, itemtitle: data[index].title))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //  height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('http://sharegiants.in/ruchi/images/itemmaingroupimages/'+data[index].url, height: containerh / 1.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 10, width: width / 2,
                        child: Text(
                          data[index].title, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}


