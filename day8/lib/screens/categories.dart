import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Categories Page'),
      ),
      body:Container(child:  ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('products');
                },
                child: Text('Go to Products'),
              ),),
    );
  }
}