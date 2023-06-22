import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HTTPTestPage extends StatefulWidget {
  const HTTPTestPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HTTPTestPage> createState() => _HTTPTestPageState();
}

class _HTTPTestPageState extends State<HTTPTestPage> {
  late Future<String> serverResponse;

  @override
  void initState() {
    super.initState();
    serverResponse = fetchLinksHome();
  }

  Future<String> fetchLinksHome() async {
    String imageList = '';
    // code to talk to server
    try {
      Uri link = Uri.parse('http://10.0.2.2:5000/');
      http.MultipartRequest request = http.MultipartRequest('GET', link);

      final http_result = await request.send();
      final text = await http_result.stream.bytesToString();
      print(http_result);
      print(text);
      imageList = text;
      return text as String;
    } catch (e) {
      print('error caught: $e');
    }

    return imageList as String;
  }

  Future<String> fetchLinksHello() async {
    String imageList = '';
    // code to talk to server
    try {
      Uri link = Uri.parse('http://10.0.2.2:5000/hello');
      http.MultipartRequest request = http.MultipartRequest('GET', link);

      final http_result = await request.send();
      final text = await http_result.stream.bytesToString();
      print(http_result);
      print(text);
      imageList = text as String;
      return text;
    } catch (e) {
      print('error caught: $e');
    }

    return imageList as String;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text("Root"),
              onPressed: () {
                setState(() {
                  serverResponse = fetchLinksHome();
                });
              },
            ),
            TextButton(
              child: Text("Hello Button"),
              onPressed: () {
                setState(() {
                  serverResponse = fetchLinksHello();
                });
              },
            ),
            FutureBuilder<String>(
                future: serverResponse,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  String text = snapshot.data as String;
                  return Text(text);
                })
          ],
        ),
      ),
    );
  }
}
