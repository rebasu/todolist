import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Addpage extends StatefulWidget {
  const Addpage({ Key? key }) : super(key: key);

  @override
  _AddpageState createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new titile'),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
                  controller: todo_title,
                  decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20,),
            TextField(
                  minLines: 5,
                  maxLines: 5,
                  controller: todo_detail,
                  decoration: InputDecoration(
                  labelText: 'detail',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                    child: Text("ADD-ON"), 
                    onPressed: () {
                      print('----------------');
                      print('title: ${todo_title.text}');
                      print('detail: ${todo_detail.text}');
                      print('----------------');
                      postTodo();
                      setState(() {
                        todo_title.clear();
                        todo_detail.clear();
                      });
                    }, 
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(25, 12, 25, 12)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))
                      ),
                    ),
            ) 
          ],
        ),
      )
    );
  }

  Future postTodo() async {
    // var url = Uri.https('60cb-2001-fb1-c8-8d39-f5bc-b975-624a-7195.ngrok.io', '/api/post-todolist');
    var url = Uri.http('192.168.1.43:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('----------------');
    print(response.body);
    }
  }