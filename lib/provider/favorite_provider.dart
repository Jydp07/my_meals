import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymeals/models/meal.dart';


class favoriteMealNotifier extends StateNotifier<List<Meal>>{
  favoriteMealNotifier() : super([]);

  bool toggleFavorite(Meal meal){
    final isFavorite = state.contains(meal);

    if(isFavorite){
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }else{
      state = [...state,meal];
      return true;
    }
  }
}
final favoriteMealProvider = StateNotifierProvider<favoriteMealNotifier, List<Meal>>((ref) {
  return favoriteMealNotifier();
});