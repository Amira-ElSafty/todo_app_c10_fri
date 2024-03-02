import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_fri/auth/login/login_screen.dart';
import 'package:flutter_app_todo_c10_fri/home/settings/settings_tab.dart';
import 'package:flutter_app_todo_c10_fri/home/task_list/add_task_bottom_sheet.dart';
import 'package:flutter_app_todo_c10_fri/home/task_list/task_list_tab.dart';
import 'package:flutter_app_todo_c10_fri/providers/list_provider.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProviders = Provider.of<AuthProviders>(context);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.2,
          actions: [
            IconButton(
                onPressed: () {
                  listProvider.tasksList = [];
                  authProviders.currentUser = null;
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                icon: Icon(Icons.logout))
          ],
          title: Text(
            'To Do List {${authProviders.currentUser!.name!}}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Task_List'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTaskBottomSheet();
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: selectedIndex == 0 ? TaskListTab() : SettingsTab());
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskBottomSheet());
  }
}
