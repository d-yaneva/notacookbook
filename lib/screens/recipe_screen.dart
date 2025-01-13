import 'package:flutter/material.dart';
import 'package:notacookbook/features/recipe_model.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  // Track the checked ingredients
  late List<bool> checkedIngredients;

  @override
  void initState() {
    super.initState();
    // Initialize checkedIngredients list based on the number of ingredients
    checkedIngredients = List<bool>.filled(widget.recipe.ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: DefaultTabController(
        length: 2, // Two tabs: Ingredients and Steps
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Ingredients'),
                Tab(text: 'Steps'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Ingredients tab with checkboxes on the right
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: widget.recipe.ingredients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(widget.recipe.ingredients[index]),
                              ),
                              Checkbox(
                                value: checkedIngredients[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkedIngredients[index] = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Steps tab
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: widget.recipe.steps.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(widget.recipe.steps[index].keys.first),
                          subtitle: Text('Time: ${widget.recipe.steps[index].values.first} minutes'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
