//this file will be used to get some styling for the categories items.

import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final void Function() onSelectCategory;
  final Category category;

  @override
  Widget build(BuildContext context) {
    //the inkwell to make the items tabable, to go to another screen.
    return InkWell(
      onTap: onSelectCategory,
      //splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        //we do padding for all the directions by 16.
        padding: const EdgeInsets.all(16),
        //here we set some styling for each item of the categories.
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          //for the background color
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        //text style
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
