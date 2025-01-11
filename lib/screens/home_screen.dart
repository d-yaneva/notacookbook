import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
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
        title: Text(
          title,
          style: GoogleFonts.lilyScriptOne(fontSize: 24), // AppBar font style
        ),
        centerTitle: true, // Centers the title in the AppBar
      ),
      body: Container(
        color: const Color(0xFFFAEDCD), // Background color
        child: Column(
          children: [
            // Lace image under the AppBar
            Image.asset(
              'assets/images/lace2.png', // Make sure the lace image is in your assets
              width: double.infinity,
              height: 50, // Adjust the height as needed
              fit: BoxFit.cover,
            ),
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
                          pageBuilder: (_, __, ___) => const RecipeListScreen(type: 'All Recipes'),
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
                          // Replace the container with an image
                          Image.asset(
                            'assets/images/home_page_widget.png', // The new image you want to use
                            width: 300,
                            height: 120, // Increased height to add space for the text
                            fit: BoxFit.cover, // Adjust the image fit to cover the container
                          ),
                          // Add a bow-like icon in the top-left corner
                          Positioned(
                            top: -10,
                            left: -10,
                            child: Image.asset(
                              'assets/images/bow.png',
                              width: 80,
                              height: 80,
                            ),
                          ),
                          // Center the text over the image
                          Positioned(
                            bottom: 10, // Move the text a bit higher or lower on the image
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                'See Recipes',
                                style: GoogleFonts.borel(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Add space between buttons
                    // Recognize Recipe Button
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const GetFoodScreen(title: 'Recognize Recipe'),
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
                          // Replace the container with an image
                          Image.asset(
                            'assets/images/home_page_widget.png', // The new image you want to use
                            width: 300,
                            height: 120, // Increased height to add space for the text
                            fit: BoxFit.cover, // Adjust the image fit to cover the container
                          ),
                          // Add a bow-like icon in the top-left corner
                          Positioned(
                            top: -10,
                            left: -10,
                            child: Image.asset(
                              'assets/images/bow.png',
                              width: 80,
                              height: 80,
                            ),
                          ),
                          // Center the text over the image
                          Positioned(
                            bottom: 10, // Move the text a bit higher or lower on the image
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                'Recognize Recipe',
                                style: GoogleFonts.borel(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
