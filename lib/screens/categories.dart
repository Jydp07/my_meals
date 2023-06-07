import 'package:flutter/material.dart';
import 'package:mymeals/models/category.dart';
import 'package:mymeals/screens/meals.dart';
import 'package:mymeals/widget/category_grid_item.dart';

import '../data/dummy_data.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.selectedFilter});

  final List<Meal> selectedFilter;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      upperBound: 1,
      lowerBound: 0,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filterMeals = widget.selectedFilter
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MealsScreen(meals: filterMeals, title: category.title),
      ),
    );
  }

  @override
  Widget build(context) {
    return AnimatedBuilder(animation: _animationController, builder: ((context, child) => SlideTransition(position: Tween(
        begin: const Offset(0,0.3),
        end: const Offset(0,0),).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
      child: child,)),
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              onSelect: () {
                _selectCategory(context, category);
              },
              category: category,
            ),
        ],
      ),
    );
  }
}
