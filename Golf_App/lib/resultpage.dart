import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  const ResultPage(
      {super.key,
      required this.title,
      required this.video1,
      required this.video2});

//need the two videos, send it to result page,
  final String title;
  final String video1;
  final String video2;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Future<List> images;

  @override
  void initState() {
    super.initState();
    images = fetchLinks();
  }

  Future<List> fetchLinks() async {
    List imageList = [];
    try {
      Uri link = Uri.parse('http://10.0.2.2:5000/analyser');
      http.MultipartRequest request = http.MultipartRequest('POST', link);

      // Define the headers and add to the request
      Map<String, String> header = {'Content-Type': 'multipart/form-data'};
      request.headers.addAll(header);

      // Add videos to the request
      request.files
          .add(await http.MultipartFile.fromPath("video1", widget.video1));
      request.files
          .add(await http.MultipartFile.fromPath("video2", widget.video2));

      final response = await request.send();
      final links = await response.stream.bytesToString();
      print(links); // links is a string

      imageList = stringToList(links);
    } catch (e) {
      print('error caught: $e');
    }

    return imageList;
  }

  List stringToList(String server_response) {
    List imageList = [];

    List splitList = server_response.split("\"]");

    for (int i = 0; i < splitList.length - 1; i++) {
      int startIdx = splitList[i].indexOf("\"");
      String pairString = splitList[i].substring(startIdx + 1);
      List pair = pairString.split("\",\"");
      imageList.add(pair);
    }
    return imageList;
  }

  Widget pairedImageRow(List pairedImages) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 120.0,
            width: 150.0,
            child: Image(
              image: NetworkImage(pairedImages[0]),
            ),
          ),
          const SizedBox(width: 40),
          SizedBox(
            height: 120.0,
            width: 150.0,
            child: Image(
              image: NetworkImage(pairedImages[1]),
            ),
          ),
        ],
      ),
    );
  }

  Widget suggestionBox() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Suggestion",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Divider(
            height: 20,
            thickness: 3,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          Container(
            height: 300,
          )
        ],
      ),
    );
  }

  Widget photoScrollView(List images) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          key: UniqueKey(),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return pairedImageRow(images[index]);
            },
            childCount: images.length,
          ),
        ),
        suggestionBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List>(
          future: images,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            List imageList = snapshot.data as List;
            return photoScrollView(imageList);
          }),
    );
  }
}
