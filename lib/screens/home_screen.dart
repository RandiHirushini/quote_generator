import 'package:flutter/material.dart';
import '../data/quotes_data.dart'; // Import the quotes data source
import '../models/quote.dart'; // Import the Quote model
import 'detail_screen.dart'; // Import the DetailScreen for navigation


/// **HomeScreen - Displays a random quote from the selected category**
/// 
/// Allows users to:
/// - Select a category from a dropdown menu.
/// - View a randomly selected quote.
/// - Navigate to a detailed quote screen.
/// - Refresh the quote with a button.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  /// The currently selected category (default is the first category).
  String selectedCategory = categories.first;

  /// The currently displayed quote.
  Quote? currentQuote;

  /// A unique key to trigger animations when a new quote is loaded.
  int quoteKey = 0;

  @override
  void initState() {
    super.initState();
    _refreshQuote(); // Load an initial quote when the screen is created.
  }

  /// **Fetches and updates a new random quote from the selected category.**
  void _refreshQuote() {
    final filteredQuotes =
        quotes.where((q) => q.category == selectedCategory).toList();
    filteredQuotes.shuffle(); // Randomize the list to get a different quote.
    setState(() {
      currentQuote = filteredQuotes.isNotEmpty ? filteredQuotes.first : null;
      quoteKey++; // Change key to trigger an animation.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50, // Light blue background

      /// **App Bar**
      /// Displays the app title with a dark blue background.
      appBar: AppBar(
        title: const Text(
          'FAMOUS QUOTES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26, // Large title font size
            color: Colors.white, 
          ),
        ),
        backgroundColor: Colors.blue.shade900, 
        centerTitle: true, // Center the app bar title
      ),

      /// **Main UI Content**
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// **CATEGORY SELECTION (Dropdown Menu)**
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center align everything
              children: [
                const SizedBox(height: 100), // Adjust spacing
                const Text(
                  'CATEGORY:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10), // Space between label and dropdown

                /// **Dropdown Menu**
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    borderRadius: BorderRadius.circular(10), 
                    border: Border.all(color: Colors.blue.shade700), 
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                          _refreshQuote(); // Update the quote when category changes
                        });
                      },
                      items: categories.map((String category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(fontSize: 16), 
                          ),
                        );
                      }).toList(),
                      dropdownColor: Colors.white, // Clean background
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30), // Space before quote card

            /// **QUOTE DISPLAY CARD**
            /// Shows the quote in a nicely styled card with a click-to-navigate feature.
            Expanded(
              child: Center( // Ensures proper centering
                child: GestureDetector(
                  onTap: () {
                    if (currentQuote != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(quote: currentQuote!),
                        ),
                      );
                    }
                  },
                  child: Card(
                    elevation: 10, // Adds shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), 
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// **Animated Quote Text**
                          /// Adds a fade-in effect when the quote updates.
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            child: Text(
                              currentQuote?.text ?? "Loading...", // Placeholder if quote is null
                              key: ValueKey<int>(quoteKey), // Unique key triggers animation
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),

                          /// **Author Name**
                          Text(
                            "- ${currentQuote?.author ?? ''}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 5),

                          /// **Tap for More Details Link**
                          Text(
                            "Tap for more details",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10), // Space before button

            /// **REFRESH BUTTON**
            /// Allows the user to fetch a new quote.
            ElevatedButton.icon(
              onPressed: _refreshQuote,
              icon: const Icon(Icons.refresh, color: Colors.white), // White refresh icon
              label: const Text("Get New Quote"), // Button text
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900, // Dark blue button
                foregroundColor: Colors.white, // White text
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
