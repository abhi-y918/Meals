import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screeens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screeens/meals.dart';
import 'package:meals/models/category.dart' ;

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context,Category category) {
    // context stateless mein globally nhi hota hai
    final filteredMeals =dummyMeals.where((meal)=>meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Your Category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          //alternative of for
          // availableCategories.map((category)=>CategoryGridItem(category:category)).tolist()
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
                onSelectCategory:(){
                _selectCategory(context,category);
                }
            ),
        ],
      ),
    );
  }
}
