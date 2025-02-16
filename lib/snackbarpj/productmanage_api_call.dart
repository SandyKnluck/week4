import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:week4/snackbarpj/productmanage_model.dart';
import 'product_form_page.dart';

class ProductmanageApiCall extends StatefulWidget {
  const ProductmanageApiCall({super.key});

  @override
  State<ProductmanageApiCall> createState() => _ProductmanageApiCallState();
}

class _ProductmanageApiCallState extends State<ProductmanageApiCall> {
  bool isLoaded = true;
  List<Product> product = [];
  Future<void> fetchData() async {
    try {
      var response =
          await http.get(Uri.parse('http://localhost:8001/products'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        //print(jsonList);
        setState(() {
          product = jsonList.map((item) => Product.fromJson(item)).toList();
          isLoaded = true;
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

/*
  Future<void> createProduct() async {
    try {
      var response = await http.post(
          Uri.parse("http://localhost:8001/products"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "name": "iPhone 5s",
            "description": "Apple smartphone",
            "price": 21999.00
          }));
      if (response.statusCode == 201) {
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProduct({dynamic idUpdate = "44b7"}) async {
    try {
      var response = await http.put(
          Uri.parse("http://localhost:8001/products/$idUpdate"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "name": "iPhone 5 plus",
            "description": "Apple smartphone",
            "price": 34900.00
          }));
      if (response.statusCode == 200) {
//code somthing...
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProduct({dynamic idDelete = "44b7"}) async {
    try {
      var response = await http
          .delete(Uri.parse("http://localhost:8001/products/$idDelete"));
      if (response.statusCode == 200) {
//code somthing...
      } else {
        throw Exception("Failed to delete products");
      }
    } catch (e) {
      print(e);
    }
  }
*/
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: isLoaded
          ? ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: product.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text('${product[index].id}'),
                  title: Text('${product[index].name}'),
                  subtitle: Text('${product[index].description}'),
                  trailing: Text('(${product[index].price})'),
                );
              })
          : const Center(child: Text('loading...')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
