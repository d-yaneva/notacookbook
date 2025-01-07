import 'package:flutter/material.dart';

class RecipeListScreen extends StatelessWidget {
  final String type;

  const RecipeListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    // Sample list of recipes based on type
    final List<Map<String, String>> recipes = getRecipes(type);

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            title: recipes[index]['title']!,
            image: recipes[index]['image']!,
            description: recipes[index]['description']!,
          );
        },
      ),
    );
  }

  List<Map<String, String>> getRecipes(String type) {
    // Sample data, you can modify this to be dynamic based on the recipe type
    if (type == 'Breakfast') {
      return [
        {
          'title': 'Pancakes',
          'image': 'assets/images/pancakes.jpg',
          'description': 'Fluffy pancakes served with syrup and butter.',
        },
        {
          'title': 'Omelette',
          'image': 'assets/images/omelette.jpg',
          'description': 'A classic omelette with cheese and vegetables.',
        },
      ];
    } else if (type == 'Lunch/Dinner') {
      return [
        {
          'title': 'Spaghetti Bolognese',
          'image': 'assets/images/spaghetti_bolognese.jpg',
          'description': 'A rich and flavorful Bolognese sauce over spaghetti.',
        },
        {
          'title': 'Grilled Chicken',
          'image': 'assets/images/grilled_chicken.jpg',
          'description': 'Tender grilled chicken with a side of veggies.',
        },
      ];
    } else if (type == 'Dessert') {
      return [
        {
          'title': 'Chocolate Cake',
          'image': 'assets/images/chocolate_cake.jpg',
          'description': 'A moist and rich chocolate cake with frosting.',
        },
        {
          'title': 'Apple Pie',
          'image': 'assets/images/apple_pie.jpg',
          'description': 'Classic apple pie with a flaky crust.',
        },
      ];
    } else {
      return [];
    }
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const RecipeCard({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Image.asset(
          image,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          // Implement navigation to a detailed recipe screen if needed
        },
      ),
    );
  }
}
