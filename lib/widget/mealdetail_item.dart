import 'package:flutter/material.dart';
import 'package:mymeals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailItem extends StatelessWidget {
  const MealDetailItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: meal.id,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Ingredients',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12,),
          for (final ingredient in meal.ingredients)
            Padding(
              padding: const EdgeInsets.only(left: 12.0,bottom: 6),
              child: Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Recipe',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12,),
          for (final step in meal.steps)
            Padding(
              padding: const EdgeInsets.only(left: 12.0,bottom: 6),
              child: Text(
                step,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
        ],
      ),
    );
  }
}
