import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_fri/home/task_list/task_list_item.dart';
import 'package:flutter_app_todo_c10_fri/my_theme.dart';
import 'package:flutter_app_todo_c10_fri/providers/auth_providers.dart';
import 'package:flutter_app_todo_c10_fri/providers/list_provider.dart';
import 'package:provider/provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: listProvider.selectDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              listProvider.changeSelectedDate(
                  date, authProvider.currentUser!.id!);
            },
            leftMargin: 20,
            monthColor: MyTheme.blackLightColor,
            dayColor: MyTheme.blackLightColor,
            activeDayColor: MyTheme.whiteColor,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskListItem(
                  task: listProvider.tasksList[index],
                );
              },
              itemCount: listProvider.tasksList.length,
            ),
          )
        ],
      ),
    );
  }
}
