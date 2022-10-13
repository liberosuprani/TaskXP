import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
    final listaData = Provider.of<Tarefas>(context);
    final lista = listaData.itens;

    final appBar = AppBar(
      title: const Text('Concluídas'),
      backgroundColor: Color(0xFF3E3E3E),
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
                  Center(child: Text('Você não possui nenhuma tarefa!', style: TextStyle(fontSize: 20, color: Colors.white), )),
                ],
              ),
            )
                : ListaDeTarefas(listaData.concluidas),
          ],
        ),
        floatingActionButton: const MyFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

