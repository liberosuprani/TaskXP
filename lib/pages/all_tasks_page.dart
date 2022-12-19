import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_xp_app/widgets/popupmenu.dart';
import '../widgets/my_fab.dart';
import '../providers/tarefas.dart';
import '../widgets/lista_de_tarefas.dart';
import '../widgets/chart.dart';

class AllTasksPage extends StatefulWidget {
  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Todas as tarefas'),
      backgroundColor: Color(0xFF3E3E3E),
      actions: [
        PopUpMenu(),
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
            ListaDeTarefas('allTasks'),
          ],
        ),
        floatingActionButton: const MyFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
