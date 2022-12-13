import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_xp_app/services/FirestoreService.dart';
import './pages/removed_tasks_page.dart';
import './pages/all_tasks_page.dart';
import './pages/done_tasks_page.dart';
import './pages/login_page.dart';
import './pages/todo_tasks_page.dart';
import './pages/home_page.dart';
import './providers/tarefas.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import './pages/today_tasks_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Tarefas()),
        StreamProvider.value(value: FirestoreService().lerTarefas(collectionPath: '/tasks'), initialData: null,)
      ],
      child: MaterialApp(
        home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return HomePage();
          }
          else {
            return LoginPage();
          }
        } ,),
        debugShowCheckedModeBanner: false,
        title: 'TaskXP',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        // initialRoute: '/login_page',
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



