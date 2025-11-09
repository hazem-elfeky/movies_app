import 'package:flutter/material.dart';
import 'package:my_movies/features/main/presentation/widgets/movie_section_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(title: const Text(" Movies Home"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 12),
            MovieSectionWidget(title: "Now Playing", type: "now_playing"),
            SizedBox(height: 24),
            MovieSectionWidget(title: "Popular", type: "popular"),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
