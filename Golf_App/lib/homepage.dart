import 'package:flutter/material.dart';
import 'package:flutter_tests/Recordpage.dart';
import 'package:flutter_tests/HTTPTestPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void nextpage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const RecordPage(title: "Choose Videos")));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login:', style: TextStyle(fontSize: 25)),
            SizedBox(height: 5),
            const SizedBox(
              width: 250,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 10),
            const SizedBox(
              width: 250,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(
              width: 80.0,
              child: ElevatedButton(
                  onPressed: nextpage,
                  child: Text("Log in", textAlign: TextAlign.center)),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 250.0,
              child: ElevatedButton(
                  onPressed: nextpage,
                  child:
                      Text("Continue As Guest", textAlign: TextAlign.center)),
            ),
          ],
        ),
      ),
    );
  }
}
