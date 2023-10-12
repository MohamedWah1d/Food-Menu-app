//This file will contain the tabs in the bottom of the application

import 'package:flutter/material.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/screens/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filter_provider.dart';

//Global variable to set initialize the values of the filters.
const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  //variable to naigate between the bars
  int _selectedPageIndex = 0;

  //function to get the index of the selected bar screen
  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //to change the screen on the tabs screen.
  //async here to get the value of the filters on the tabs screen.
  void _setScreen(String identifier) async {
    //when the user press on the meals in the drawer.
    Navigator.of(context).pop();

    //if the user picked the filter
    if (identifier == 'filters') {
      //getting the result of the filters screen and also navigate to it.
      //we ge the result by making a map, that maps each value of the filter to a specfic variable
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //to get the filters the user set
    final availableMeals = ref.watch(filterMealsProvider);

    //A variable to select the title of the selcted item on the bar
    var activePageTitle = 'Categories';
    //to select the which page to go to in the bar
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    //to go to the favourite screen when the user tabs on it
    if (_selectedPageIndex == 1) {
      //getting the value of the favorite provider
      //watch function keeps listening + reading the values of the data if changed.
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your favoutites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      //to do the navigetor bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Your favourites',
          ),
        ],
      ),
    );
  }
}
