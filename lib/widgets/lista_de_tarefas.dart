import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_xp_app/providers/tarefas.dart';
import 'package:task_xp_app/services/FirestoreService.dart';
import 'package:task_xp_app/widgets/list_item.dart';
import '../models/tarefa.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './editor_de_tarefa.dart';
import './nova_tarefa.dart';
import 'package:provider/provider.dart';

class ListaDeTarefas extends StatefulWidget {

  String collectionPath;

  ListaDeTarefas(this.collectionPath);

  @override
  State<ListaDeTarefas> createState() => _ListaDeTarefasState();
}

class _ListaDeTarefasState extends State<ListaDeTarefas> {

  final db = FirestoreService();
  late Stream<List<Tarefa>> x;

  @override
  void initState() {
    x = db.lerTarefas(collectionPath: widget.collectionPath);
  }

  void changeFinalizado(Tarefa t, bool finalizado) {
    db.changeItem(t);
    if (finalizado) {
      db.removeItem(t.id, collectionPath: 'todayTasks');
      db.adicionarTarefa(t, 'doneTasks');
    }
    else {
      db.removeItem(t.id, collectionPath: 'doneTasks');
      db.ondeAdicionar(t);
    }
  }

  final now = DateTime.now();
  Color corData (Tarefa t){
    if (DateTime(t.data.year, t.data.month, t.data.day).difference(DateTime(now.year, now.month, now.day)).inDays == 0){
      return Colors.orange;
    }
    else if (DateTime(t.data.year, t.data.month, t.data.day).difference(DateTime(now.year, now.month, now.day)).inDays < 0) {
      return Colors.red;
    }
    else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tarefa>>(
      stream: x,
      builder: (bcontext, streamSnapshot) {
        if (streamSnapshot.hasData) {
          final documents = streamSnapshot.data!;
          if (documents.length == 0){
            if (ModalRoute.of(context)?.settings.name != '/removed_tasks_page') {
              return Flexible(
                fit: FlexFit.loose,
                child: Column(
                  children: const [
                    SizedBox(height: 50,),
                    Center(child: Text('Você não possui nenhuma tarefa!',
                      style: TextStyle(fontSize: 20, color: Colors.white),)),
                  ],
                ),
              );
            }
            else {
              return Flexible(
                fit: FlexFit.loose,
                child: Column(
                  children: const [
                    SizedBox(height: 50,),
                    Center(child: Text('Lixeira vazia!',
                      style: TextStyle(fontSize: 20, color: Colors.white),)),
                  ],
                ),
              );
            }
          }
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (ctx, indice) {
                if (indice == documents.length){
                  return SizedBox(height: 80,);
                }
                var t = documents[indice];
                bool finalizado = t.finalizado;
                return ListItem(t, collectionPath: widget.collectionPath,);
              },
            ),
          );
        }
        else {
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}


