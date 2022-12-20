import 'package:flutter/material.dart';
import '../widgets/my_fab.dart';
import '../widgets/lista_de_tarefas.dart';
import '../widgets/chart.dart';
import '../widgets/popupmenu.dart';

class TodayTasksPage extends StatefulWidget {
  @override
  State<TodayTasksPage> createState() => _TodayTasksPageState();
}

class _TodayTasksPageState extends State<TodayTasksPage> {

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Hoje'),
      backgroundColor: Color(0xFF3E3E3E),
      actions: [
        PopUpMenu(collectionPath: 'todayTasks'),
      ],
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF545454),
        appBar: appBar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(),
            ListaDeTarefas('todayTasks'),
          ],
        ),
        floatingActionButton: const MyFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

