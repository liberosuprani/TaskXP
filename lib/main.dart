import 'package:flutter/material.dart';
import 'package:task_xp_app/pages/removed_tasks_page.dart';
import './pages/all_tasks_page.dart';
import './pages/done_tasks_page.dart';
import './pages/login_page.dart';
import './pages/todo_tasks_page.dart';
import './pages/home_page.dart';
import './providers/tarefas.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import './pages/today_tasks_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Tarefas(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TaskXP',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/home_page',
        routes: {
          '/login_page' : (context) => LoginPage(),
          '/home_page' : (context) => const HomePage(),
          '/today_tasks_page' : (context) => TodayTasksPage(),
          '/all_tasks_page' : (context) => AllTasksPage(),
          '/done_tasks_page' : (context) => DoneTasksPage(),
          '/todo_tasks_page' : (context) => TodoTasksPage(),
          '/removed_tasks_page' : (context) => RemovedTasksPage(),
        },
      ),
    );


  }
}



