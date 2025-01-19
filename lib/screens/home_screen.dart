import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:notacookbook/screens/get_food_screen.dart';
import 'package:notacookbook/screens/recipe_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          title,
          style: GoogleFonts.lilyScriptOne(fontSize: 35),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
    
          Container(
            color: const Color(0xFFCCD5AE), 
          ),
          
           Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.3, 
              child: Image.asset(
                'assets/images/background.png', 
                width: double.infinity,
                height:  MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),

Positioned(
  top: AppBar().preferredSize.height - 65, 
  left: 0,
  right: 0,
  child: Image.asset(
    'assets/images/lace2.png',
    width: double.infinity,
    height: 60, 
    fit: BoxFit.cover,
  ),
),

          

          // Main content (buttons in the column)
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // See Recipes Button
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const RecipeListScreen(type: 'All Recipes'), // Pass 'All Recipes'
                            transitionsBuilder: (_, animation, __, child) {
                              const begin = Offset(-1.0, 0.0); // Start from the left
                              const end = Offset.zero; // End at the center
                              const curve = Curves.easeInOut;

                              final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none, // To allow the icon to overflow
                          children: [
                            Image.asset(
                              'assets/images/home_page_widget.png',
                              width: 380,
                              height: 120,
                              fit: BoxFit.cover, 
                            ),
                            Positioned(
                              top: -10,
                              left: -10,
                              child: Image.asset(
                                'assets/images/bow.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center, 
                                child: Text(
                                  'See Recipes',
                                  style: GoogleFonts.lilyScriptOne(
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30), // Space between buttons
                      
                      // Recognize Recipe Button
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const GetFoodScreen(title: 'Recognize Recipe'),
                            transitionsBuilder: (_, animation, __, child) {
                              const begin = Offset(-1.0, 0.0); 
                              const end = Offset.zero; 
                              const curve = Curves.easeInOut;

                              final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none, // To allow the icon to overflow
                          children: [
                            Image.asset(
                              'assets/images/home_page_widget.png',
                              width: 380,
                              height: 120,
                              fit: BoxFit.cover, 
                            ),
                            Positioned(
                              top: -10,
                              left: -10,
                              child: Image.asset(
                                'assets/images/bow.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center, 
                                child: Text(
                                  'Recognize Recipe',
                                  style: GoogleFonts.lilyScriptOne(
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
