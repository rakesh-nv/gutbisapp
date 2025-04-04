
import 'package:flutter/cupertino.dart';

class FavouriteProvider with ChangeNotifier{
  List<int> _selectedItem = [];

  List<int> get selectedItem => _selectedItem;

  // void addItem(int value){
  //   _selectedItem.add(value){
  //     notifyListeners();
  //   }
  // }
}