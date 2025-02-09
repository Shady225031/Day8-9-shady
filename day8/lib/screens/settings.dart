import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Settings Page'),
      ),
      body:Container(child:  ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('categories');
                },
                child: Text('Go to Categories'),
              ),
      ),
    );
  }
}