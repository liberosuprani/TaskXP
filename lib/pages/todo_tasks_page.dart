import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/my_fab.dart';
import '../providers/tarefas.dart';
import '../widgets/lista_de_tarefas.dart';
import '../widgets/chart.dart';
import '../widgets/popupmenu.dart';

class TodoTasksPage extends StatefulWidget {
  @override
  State<TodoTasksPage> createState() => _TodoTasksPageState();
}

class _TodoTasksPageState extends State<TodoTasksPage> {

  @override
  Widget build(BuildContext context) {
    final listaData = Provider.of<Tarefas>(context);
    final lista = listaData.itens;

    final appBar = AppBar(
      title: const Text('A fazer'),
      backgroundColor: Color(0xFF3E3E3E),
      actions: [
        PopUpMenu(lista),
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
            lista.isEmpty ?
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                children: const [
                  SizedBox(height: 50,),
                  Center(child: Text('Não há tarefas a fazer', style: TextStyle(fontSize: 20, color: Colors.white), )),
                ],
              ),
            )
                : ListaDeTarefas(listaData.inconcluidas),
          ],
        ),
        floatingActionButton: const MyFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

