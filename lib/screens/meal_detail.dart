import 'package:flutter/material.dart';
import 'package:mymeals/provider/favorite_provider.dart';
import 'package:mymeals/widget/mealdetail_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealProvider);

    final isFavorite = favoriteMeals.contains(meal);
    void showInfoMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded =
                  ref.read(favoriteMealProvider.notifier).toggleFavorite(meal);
              showInfoMessage(wasAdded ? 'Meal Added' : 'Meal Removed');
            },
            icon: AnimatedSwitcher(
              duration: const Duration(seconds: 3),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(
                    begin: .9,
                    end: 1.0
                  ).animate(animation),
                  child: child,
                );
              },
              child: Icon(isFavorite ? Icons.star : Icons.star_border,key: ValueKey(isFavorite),),
            ),
          ),
        ],
      ),
      body: MealDetailItem(meal: meal),
    );
  }
}
