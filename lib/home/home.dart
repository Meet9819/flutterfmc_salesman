import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fmc_salesman/Item_group_screen/item_main.dart';
import 'package:fmc_salesman/home/home_category_main_group.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;

class SliderGrid extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final height=MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(4.0),
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Shop By Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.more,
                          color: Colors.blue,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Item_main()));
                        },
                      )
                    ],
                  )),
              Container(
                //height: 175,
                constraints: BoxConstraints.expand(height: height/2),
                child: ItemPage(),
              ),
              SizedBox(
                height: 20,
              ),

            ],
          )
        ],
      ),
    );
  }
}

class SliderIndicator extends AnimatedWidget {
  final PageController pageController;
  final int indicatorCount;

  SliderIndicator({this.pageController, this.indicatorCount})
      : super(listenable: pageController);
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(indicatorCount, buildIndicator));
  }

  Widget buildIndicator(int index) {
    final page = pageController.position.minScrollExtent == null
        ? pageController.initialPage
        : pageController.page;
    bool active = page.round() == index;
    print("build $index ${pageController.page}");
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Center(
          child: Container(
              width: 20,
              height: 5,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}

class Job {
  final String url;

  Job({
    this.url,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      url: json['url'],
    );
  }
}

class GalleryDemo extends StatelessWidget {
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
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl =
        'http://sharegiants.in/ruchi/doctor_api.php?action=fetch_all';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Swiper imageSlider(context, data) {
  return new Swiper(
    //autoplay: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        data[index].url,
        fit: BoxFit.fitWidth,
        width: 300,
      );
    },

    viewportFraction: 0.4,

    scale: 0.5,
  );
}
