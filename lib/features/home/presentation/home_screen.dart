import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savr_sense/core/navigation/screen_registry.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> cardTitles = const [
    'Raw Ingredient',
    'Processed Good',
    'Dish',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SavrSense')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 cards per row
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio:
                0.7, // Adjusted ratio for smaller cards; tweak as needed
          ),
          itemCount: cardTitles.length,
          itemBuilder: (context, index) {
            final ScreenInfo? screenInfo = ScreenRegistry.getScreenInfo(
              cardTitles[index],
            );

            return GestureDetector(
              onTap: () {
                if (screenInfo != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screenInfo.screen),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Screen not found')),
                  );
                }
              },
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate image height as 50% of the card height.
                    final double imageHeight = constraints.maxHeight * 0.5;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: imageHeight,
                          child: Center(
                            child:
                                screenInfo != null &&
                                        screenInfo.imagePath.isNotEmpty
                                    ? SvgPicture.asset(
                                      screenInfo.imagePath,
                                      fit: BoxFit.contain,
                                    )
                                    : const Icon(
                                      Icons.image_not_supported,
                                      size: 40.0,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            cardTitles[index],
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
