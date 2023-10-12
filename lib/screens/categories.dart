//This class is for showing the categories by making a grid view.

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  //variable will contain the meals after applying the filter
  final List<Meal> availableMeals;

  //Function to navigate to another screen, when click on an item category
  void _selectCategory(BuildContext context, Category category) {
    //This variable to get all the meals inside a cretain category.
    final fulteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //To go to a different screen showing the meals of that category item
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: fulteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      //The griddelgate for setting the spacing and how many column we want for our grids
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //two columns
        childAspectRatio: 3 / 2,
        //those last two for vertical and horizontal spacing
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      //here we will show the content of each Item on the grid.
      children: [
        //looping through all the items to show them.
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
