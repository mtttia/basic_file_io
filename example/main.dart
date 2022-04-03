import 'package:basic_file_io/basic_file_io.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FileAssistant _file = FileAssistant('file.txt');
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _file.load().then((value) {
      setState(() {});
    });
  }

  void updateFile() {
    _file.setData(_controller.text).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // return a material app
    return MaterialApp(
      // set the title of the app
      title: 'Basic File IO',
      // set the theme of the app
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      // set the home of the app
      home: Scaffold(
        // set the appbar
        appBar: AppBar(
          // set the title of the appbar
          title: const Text('Basic File IO'),
        ),
        // set the body of the app
        body: Center(
          // set the text of the body
          child: Column(
            children: [
              Row(
                children: [
                  Text('file content : '),
                  Text(_file.data)
                ],
              ),
              Row(
                children: [
                  TextField(
                    controller: _controller,
                  ),
                  TextButton(
                    onPressed: updateFile, 
                    child: Text('save')
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
