
import 'package:flutter/material.dart';

class DialogHelper{

  static showProgressIndicator(bool visibility){
    Visibility(visible :visibility, child:  const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
    );
  }
}