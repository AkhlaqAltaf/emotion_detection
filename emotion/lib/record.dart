import 'package:flutter/material.dart';

class Record extends ChangeNotifier {
  List<dynamic> emotions = [];

  updateEmotions(emotion) {
    emotions.add(emotion);
    notifyListeners();
  }

  getEmotions() {
    return emotions;
  }
}
