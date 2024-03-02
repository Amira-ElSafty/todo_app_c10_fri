import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_fri/dialog_utils.dart';
import 'package:flutter_app_todo_c10_fri/home/firebase_utils.dart';
import 'package:flutter_app_todo_c10_fri/providers/auth_providers.dart';
import 'package:flutter_app_todo_c10_fri/providers/list_provider.dart';
import 'package:flutter_app_todo_c10_fri/model/task.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onChanged: (text) {
                      title = text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter task title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Enter Task Title'),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      description = text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter task description'; // invalid
                      }
                      return null; // valid
                    },
                    decoration:
                        InputDecoration(hintText: 'Enter Task Description'),
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Select Date',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      showCalender();
                    },
                    child: Text(
                      '${selectedDate.day}/${selectedDate.month}'
                      '/${selectedDate.year}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.titleLarge,
                      ))
                ],
              ))
        ],
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    print('chosen date : $chosenDate');
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
    // selectedDate = chosenDate  ?? DateTime.now();
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      // add task
      DialogUtils.showLoading(context: context, message: 'Loading...');
      Task task =
      Task(title: title, description: description, dateTime: selectedDate);
      var authProvider = Provider.of<AuthProviders>(context, listen: false);
      FirebaseUtils.addTaskToFireStore(task, authProvider.currentUser!.id!)
          .then((value) {
        print('task added successfully');
        Navigator.pop(context);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context, message: 'Task added Successully',
            posActionName: 'Ok');

        /// alert dialog , toast , snack bar
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
      });
      //     .timeout(Duration(milliseconds: 500), onTimeout: () {
      //   print('task added successfully');
      //   /// alert dialog , toast , snack bar
      //   listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
      //   Navigator.pop(context);
      // });
    }
  }
}
