import 'dart:io';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeListScreen(type: 'Breakfast'),
                ),
              ),
              child: Container(
                width: 300,
                height: 100,
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text(
                  'Breakfast Recipes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeListScreen(type: 'Lunch/Dinner'),
                ),
              ),
              child: Container(
                width: 300,
                height: 100,
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text(
                  'Lunch/Dinner Recipes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeListScreen(type: 'Dessert'),
                ),
              ),
              child: Container(
                width: 300,
                height: 100,
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text(
                  'Dessert Recipes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeListScreen extends StatelessWidget {
  final String type;

  const RecipeListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Recipes'),
      ),
      body: Center(
        child: Text(
          'This is the layout for $type recipes.',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
