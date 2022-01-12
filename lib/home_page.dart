import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio = Dio();
  String firstTitle = 'Press the button';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    firstTitle = 'Press the button';
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                CircularProgressIndicator()
              else
                Text(
                  firstTitle,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final response = await dio
                        .get('https://jsonplaceholder.typicode.com/posts');
                    setState(() {
                      firstTitle = response.data[0]['title'] as String;
                      isLoading = false;
                    });
                    print(response.statusCode);
                  },
                  child: Text('REQUEST DATA'))
            ],
          ),
        ),
      ),
    );
  }
}
