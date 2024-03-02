import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_fri/home/firebase_utils.dart';
import 'package:flutter_app_todo_c10_fri/model/task.dart';

class ListProvider extends ChangeNotifier {
  // data
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollections(uId).get();

    /// List<QueryDocumentSnapshot<Task>>   => List<Task>
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// fitter => select date
    /// 23/2/2023
    tasksList = tasksList.where((task) {
      if (selectDate.day == task.dateTime!.day &&
          selectDate.month == task.dateTime!.month &&
          selectDate.year == task.dateTime!.year) {
        return true;
      }
      return false;
    }).toList();

    /// sorting
    tasksList.sort((task1, task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });

    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate, String uId) {
    selectDate = newSelectedDate;
    getAllTasksFromFireStore(uId);
    notifyListeners();
  }
}
