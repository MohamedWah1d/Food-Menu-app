//This file will contain the styling of the meals items

import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  //Function to get the complexity of the meal with a specific format
  String get complexityText {
    //making the first charachter upper case and the rest lowecase
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  //Function to get the affordability of the meal with a specific format
  String get affordabilityText {
    //making the first charachter upper case and the rest lowecase
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior:
          Clip.hardEdge, // to force the stack widget to do the rounded edges.
      elevation: 2, //to add some 3d effects.
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        //To show the items in a way that they are in a column
        child: Stack(
          children: [
            //hero : is to add animation to the pictute when going back from different screens.
            Hero(
              tag: meal.id,
              //to make the Image a liitle bit faded away.
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            //Where to put the meal content on top of the image.
            //the box that contains the meal title.
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(horizontal: 44, vertical: 6),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow
                          .ellipsis, //to cut of very long texts like ...
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      //to center the texts.
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //adding the duration info and Icon
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        //adding the complexty label and icon
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        //adding the affordability name and icon
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
