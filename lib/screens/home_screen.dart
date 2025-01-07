import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notacookbook/screens/get_food_screen.dart';
import 'package:notacookbook/screens/recipe_list.dart';

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
      body: Container(
        color: Color(0xFFFAEDCD), //background color
        child: Center(
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/breakfast.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Breakfast Recipes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      backgroundColor: Colors.white70,
                    ),
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/lunch_dinner.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Lunch/Dinner Recipes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      backgroundColor: Colors.white70,
                    ),
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/dessert.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Dessert Recipes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      backgroundColor: Colors.white70,
                    ),
                  ),
                ),
              ),
              // New GestureDetector to navigate to GetFoodScreen
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetFoodScreen(title: 'Get a recipe from picture'),
                  ),
                ),
                child: Container(
                  width: 300,
                  height: 100,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/food_recognition.jpg'), // Add an image of your choice
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Food Recognition',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      backgroundColor: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
