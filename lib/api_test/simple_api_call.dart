import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:week4/model/user_data.dart';

class SimpleApiCall extends StatefulWidget {
  const SimpleApiCall({super.key});

  @override
  State<SimpleApiCall> createState() => _SimpleApiCallState();
}

class _SimpleApiCallState extends State<SimpleApiCall> {
  List<UserData> users = [];
  bool isLoaded = true;

  Future<void> fetchData() async {
    setState(() {
      isLoaded = false;
    });
    try {
      await Future.delayed(const Duration(seconds: 1));
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users/'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          users = jsonList.map((item) => UserData.fromJson(item)).toList();
          isLoaded = true;
        });
      } else {
        print('Invalid Data');
        setState(() {
          isLoaded = true;
        });
      }
    } catch (e) {
      print('Error: $e');
      isLoaded = true;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Simple API Call')),
        body: isLoaded
            ? ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text('${users[index].id}'),
                    title: Text(users[index].name),
                    subtitle: Text(users[index].email),
                    trailing: Text('(${users[index].username})'),
                  );
                })
            : const Center(child: Text('loading...')));
  }
}
