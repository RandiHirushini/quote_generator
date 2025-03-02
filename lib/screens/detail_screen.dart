import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome for icons
import '../models/quote.dart'; // Import the Quote model

/// A stateless widget that displays detailed information about a quote,
/// including the author, quote text, an optional image, and its meaning.
class DetailScreen extends StatelessWidget {
  /// The quote object containing text, author, category, meaning, and image.
  final Quote quote;

  /// Constructor requiring a [Quote] object to display its details.
  const DetailScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Background color for the entire screen 
      backgroundColor: Colors.blue.shade50,

      /// App bar with the author's name as the title
      appBar: AppBar(
        title: Text(
          quote.author, // Displays the author's name
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text for contrast
          ),
        ),
        backgroundColor: Colors.blue.shade900, 
        iconTheme: const IconThemeData(color: Colors.white), 
        centerTitle: true, // Centers the app bar title
      ),

      /// Main content inside a centered [SingleChildScrollView]
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // ========== AUTHOR IMAGE & BIO CARD ==========
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5), // Soft shadow
                  ],
                ),
                child: Column(
                  children: [
                    /// Displays the author's image only if an image path exists
                    if (quote.imagePath.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Rounded image corners
                        child: Image.asset(
                          quote.imagePath,
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover, // Ensures image fills the space
                        ),
                      ),
                    const SizedBox(height: 10),

                    /// Displays additional details about the author
                    Text(
                      quote.details,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ========== QUOTE DISPLAY CARD ==========
              Card(
                elevation: 5, // Creates a slight shadow for better UI
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      /// Displays the main quote text in bold and italic
                      Text(
                        quote.text,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),

                      /// Displays the author's name in a smaller, blue-grey font
                      Text(
                        "- ${quote.author}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ========== QUOTE MEANING SECTION ==========
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5), // Soft shadow
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Displays a row with an icon and title ("Quote Meaning")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.lightbulb, // Lightbulb icon for insight
                          color: Colors.orange,
                          size: 18,
                        ),
                        const SizedBox(width: 8),

                        /// Displays the "Quote Meaning" title in bold blue
                        const Text(
                          "Quote Meaning:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    /// Displays the meaning of the quote in standard font
                    Text(
                      quote.meaning,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30), // Extra space before the end of content
            ],
          ),
        ),
      ),
    );
  }
}
