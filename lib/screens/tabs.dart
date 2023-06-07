import 'package:flutter/material.dart';
import 'package:mymeals/provider/favorite_provider.dart';
import 'package:mymeals/provider/meals_provider.dart';
import 'package:mymeals/screens/categories.dart';
import 'package:mymeals/screens/filters.dart';
import 'package:mymeals/screens/meals.dart';
import 'package:mymeals/widget/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymeals/provider/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      await Navigator.push<Map<Filter,bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    final activeFilter = ref.watch(filtersProvider);
    final availableFilter = ref.watch(filterMealsProvider);
    Widget activeScreen = CategoriesScreen(
       selectedFilter: availableFilter,
    );
    String activeTitle = 'Home';
    final favoriteMeals = ref.watch(favoriteMealProvider);
    if (_selectPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
      );
      activeTitle = 'Your Favourite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black54,
        onTap: _selectPage,
        currentIndex: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites')
        ],
      ),
    );
  }
}
