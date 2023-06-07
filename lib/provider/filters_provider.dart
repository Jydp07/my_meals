import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymeals/provider/meals_provider.dart';


enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class filterNotifier extends StateNotifier<Map<Filter, bool>> {
  filterNotifier() : super({
    Filter.lactoseFree: false,
    Filter.glutenFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilters(Map<Filter,bool> chosenFilter){
    state = chosenFilter;
  }
  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive
    };
  }
}

final filtersProvider = StateNotifierProvider<filterNotifier,
    Map<Filter, bool>>((ref) => filterNotifier());

final filterMealsProvider = Provider((ref){
  final meals = ref.watch(mealProvider);
  final activeFilter = ref.watch(filtersProvider);
  return meals.where((meal) {
    if(activeFilter[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if(activeFilter[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    if(activeFilter[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
  }).toList();
});