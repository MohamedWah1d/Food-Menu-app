//this file will contain the provider of the favorited meals
//providers: are a way to play with data the users enters across multible screens,
//without having to refrence the data across multile screens

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

//we will make a class that works with the state Notifier object.
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //here we initialize the list of meals with an empty list, using the constructor.
  FavoriteMealsNotifier() : super([]);

  //this function will contain the logic behind adding a meal or removing a one from the favorited list
  bool toggleMealFavoriteStatus(Meal meal) {
    //this variable will contain the favorited meals.
    final mealIsFavorite = state.contains(meal);

    //If the meal is a favorite, then we wants to remove it from the list.
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }
    //if we want to add a meal to the favorited meals.
    else {
      //...satate >> means all the existing elemnts in the list will be added first. "state += meal".
      state = [...state, meal];
      return true;
    }
  }
}

//This variable will contain the provider of the favorited meals
//the statenoifier here to change if the data change.
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
