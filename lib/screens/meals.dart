import 'package:flutter/material.dart';
import 'package:mymeals/widget/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, this.title,});

  final List<Meal> meals;
  final String? title;
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(meal: meals[index],),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nothing to show',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Select the different category',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    if(meals.isNotEmpty){
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(meal: meals[index],),
      );

    }
    if(title == null){
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
