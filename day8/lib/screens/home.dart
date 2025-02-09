// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Home Page'),
        centerTitle: true, // Center the title for symmetry
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Adds spacing on sides
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(context, 'Go to Settings', 'settings'),
              SizedBox(height: 15), // Ensures equal spacing
              _buildButton(context, 'Go to Categories', 'categories'),
              SizedBox(height: 15),
              _buildButton(context, 'Go to Product List', 'products'),
              SizedBox(height: 15),
              _buildButton(context, 'Go to Movies', 'movies'),
              SizedBox(height: 15),
              _buildButton(context, 'Go to TV Shows', 'tvshows'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String route) {
    return SizedBox(
      width: 250, // Ensures all buttons are the same width
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        child: Text(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15), // Gives more button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adds rounded corners
          ),
        ),
      ),
    );
  }
}
