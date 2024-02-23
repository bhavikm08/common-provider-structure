import 'package:flutter/material.dart';

class LoadingProviders extends ChangeNotifier{

  bool isLoading=false;

  void startLoading(){
    isLoading=true;
    notifyListeners();
  }
  void stopLoading(){
    isLoading=false;
    notifyListeners();
  }
}

