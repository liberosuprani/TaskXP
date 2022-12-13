import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas.dart';
import '../widgets/lista_de_tarefas.dart';
import '../widgets/popupmenu.dart';

class RemovedTasksPage extends StatefulWidget {
  @override
  State<RemovedTasksPage> createState() => _RemovedTasksPageState();
}

class _RemovedTasksPageState extends State<RemovedTasksPage> {

  @override
  Widget build(BuildContext context) {
    final listaData = Provider.of<Tarefas>(context);
    final lista = listaData.lixeira;

    final appBar = AppBar(
      title: const Text('Lixeira'),
      backgroundColor: Color(0xFF3E3E3E),
      actions: [
        PopUpMenu(collectionPath: 'removedTasks'),
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
            SizedBox(height: 20,),
            ListaDeTarefas('removedTasks'),
          ],
        ),
      ),
    );
  }
}

