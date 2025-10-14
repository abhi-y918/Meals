import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/main.dart';
import 'package:meals/screeens/categories.dart';
import 'package:meals/screeens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}
class _TabsScreenState extends State<TabsScreen>{
  int _selectedPageIndex =0;

  final List<Meal>_favoritesMeals = [];

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message),
        ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting = _favoritesMeals.contains(meal);

    if(isExisting){
      setState(() {
        _favoritesMeals.remove(meal);
      });
      _showInfoMessage('Meal is not longer a favorite ');
      // ✅ If user is on the Favorites tab, rebuild the UI immediately
      if (_selectedPageIndex == 1) {
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {});
        });
      }

      // ✅ If the user is viewing this meal from a pushed screen (not tab),
      // go back to update the previous screen automatically
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }else{
      setState(() {
        _favoritesMeals.add(meal);
        _showInfoMessage('Meal is marked as Favorite');
      });
    }
  }
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }
  void _setScreen(String identifier){
    if(identifier=='filters'){

    }else{
      Navigator.of(context).pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus);
    var activePageTitle = 'Categories';
    if(_selectedPageIndex==1){
      activePage= MealsScreen(
        meals: _favoritesMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer:MainDrawer(onSelectScreen: _setScreen,) ,
      body: activePage,
      bottomNavigationBar:BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favorites'),
        ],

      ) ,
    );

  }
}



