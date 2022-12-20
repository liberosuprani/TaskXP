import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_xp_app/widgets/popupmenu.dart';
import '../widgets/my_fab.dart';
import '../providers/tarefas.dart';
import '../widgets/lista_de_tarefas.dart';
import '../widgets/chart.dart';

class DoneTasksPage extends StatefulWidget {
  @override
  State<DoneTasksPage> createState() => _DoneTasksPageState();
}

class _DoneTasksPageState extends State<DoneTasksPage> {

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Concluídas'),
      backgroundColor: Color(0xFF3E3E3E),
      actions: [
        PopUpMenu(collectionPath: 'doneTasks'),
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
            ListaDeTarefas('doneTasks'),
          ],
        ),
        floatingActionButton: const MyFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

