import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class RecipeListScreen extends StatefulWidget {
  final String type;

  const RecipeListScreen({super.key, required this.type});

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late String selectedType;
  late List<Map<String, String>> filteredRecipes;
  late List<Map<String, String>> allRecipes;

  @override
  void initState() {
    super.initState();
    selectedType = widget.type;
    allRecipes = getRecipes(); 
    filteredRecipes = filterRecipesByType(selectedType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$selectedType Recipes',
          style: GoogleFonts.lilyScriptOne(fontSize: 35),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(100,250, 237, 205), //background color
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search Recipes',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  filled: true, 
                  fillColor: Colors.white, 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30), 
                    borderSide: BorderSide.none, 
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
                ),
                style: GoogleFonts.lilyScriptOne(),
                onChanged: (query) {
                  setState(() {
                    filteredRecipes = filterRecipesByQuery(query);
                  });
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedType = 'Breakfast';
                      filteredRecipes = filterRecipesByType('Breakfast');
                    });
                  },
                  child: Text('Breakfast', style: GoogleFonts.lilyScriptOne()), 
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedType = 'Lunch/Dinner';
                      filteredRecipes = filterRecipesByType('Lunch/Dinner');
                    });
                  },
                  child: Text('Lunch/Dinner', style: GoogleFonts.lilyScriptOne()), 
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedType = 'Dessert';
                      filteredRecipes = filterRecipesByType('Dessert');
                    });
                  },
                  child: Text('Dessert', style: GoogleFonts.lilyScriptOne()), 
                ),
              ],
            ),
            // Recipe list
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    title: filteredRecipes[index]['title']!,
                    image: filteredRecipes[index]['image']!,
                    description: filteredRecipes[index]['description']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> getRecipes() {
    // Sample data for all recipes
    return [
      {
        'title': 'Pancakes',
        'image': 'assets/images/pancakes.jpg',
        'description': 'Fluffy pancakes served with syrup and butter.',
        'type': 'Breakfast',
      },
      {
        'title': 'Omelette',
        'image': 'assets/images/omelette.jpg',
        'description': 'A classic omelette with cheese and vegetables.',
        'type': 'Breakfast',
      },
      {
        'title': 'Spaghetti Bolognese',
        'image': 'assets/images/spaghetti_bolognese.jpg',
        'description': 'A rich and flavorful Bolognese sauce over spaghetti.',
        'type': 'Lunch/Dinner',
      },
      {
        'title': 'Grilled Chicken',
        'image': 'assets/images/grilled_chicken.jpg',
        'description': 'Tender grilled chicken with a side of veggies.',
        'type': 'Lunch/Dinner',
      },
      {
        'title': 'Chocolate Cake',
        'image': 'assets/images/chocolate_cake.jpg',
        'description': 'A moist and rich chocolate cake with frosting.',
        'type': 'Dessert',
      },
      {
        'title': 'Apple Pie',
        'image': 'assets/images/apple_pie.jpg',
        'description': 'Classic apple pie with a flaky crust.',
        'type': 'Dessert',
      },
    ];
  }

  List<Map<String, String>> filterRecipesByType(String type) {
    return allRecipes.where((recipe) => recipe['type'] == type).toList();
  }

  List<Map<String, String>> filterRecipesByQuery(String query) {
    return allRecipes
        .where((recipe) =>
            recipe['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
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
          style: GoogleFonts.lilyScriptOne(fontSize: 18, fontWeight: FontWeight.bold), 
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.lilyScriptOne(), 
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
   
        },
      ),
    );
  }
}

