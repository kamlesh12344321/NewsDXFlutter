
import 'package:flutter/cupertino.dart';

class BookMarkIndex with ChangeNotifier {

  BookMarkIndex(this.position);

  int position;

  // when `notifyListeners` is called, it will invoke
  // any callbacks that have been registered with an instance of this object
  // `addListener`.
  void BookMarkRowPosition(int index) {
    this.position = index;
    notifyListeners();
  }
}