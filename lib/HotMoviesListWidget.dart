import 'package:flutter/material.dart';
import 'HotMovieData.dart';
import 'HotMovieItemWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HotMoviesListWidget extends StatefulWidget {
  String curCity;

  HotMoviesListWidget(String city) {
    curCity = city;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotMoviesListWidgetState();
  }
}

class HotMoviesListWidgetState extends State<HotMoviesListWidget> {
  List<HotMovieData> hotMovies = new List<HotMovieData>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();

    // var data = HotMovieData('反贪风暴4', 6.3, '林德禄', '古天乐/郑嘉颖/林峯', 29013,
    //     'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551353482.webp');
    // setState(() {
    //   hotMovies.add(data);
    //   hotMovies.add(data);
    //   hotMovies.add(data);
    //   hotMovies.add(data);
    //   hotMovies.add(data);
    //   hotMovies.add(data);
    // });
  }
  void _getData() async {
    List<HotMovieData> serverDataList = new List();
    var response = await http.get(
        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&start=0&count=10');
    //成功获取数据
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (dynamic data in responseJson['subjects']) {
        HotMovieData hotMovieData = HotMovieData.fromJson(data);
        serverDataList.add(hotMovieData);
      }
      setState(() {
        hotMovies = serverDataList;
      });
    }
  }
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (hotMovies == null || hotMovies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
        return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.separated(
        itemCount: hotMovies.length,
        itemBuilder: (context, index) {
          return HotMovieItemWidget(hotMovies[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            color: Colors.black26,
          );
        },
      ),
    );
    }
  
  }
}