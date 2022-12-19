import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_xp_app/services/FirestoreService.dart';
import 'package:task_xp_app/widgets/list_item.dart';
import '../models/tarefa.dart';

class ListaDeTarefas extends StatefulWidget {

  String collectionPath;

  ListaDeTarefas(this.collectionPath);

  @override
  State<ListaDeTarefas> createState() => _ListaDeTarefasState();
}

class _ListaDeTarefasState extends State<ListaDeTarefas> {

  final service = FirestoreService();
  final db = FirebaseFirestore.instance;
  late Stream<List<Tarefa>> x;

  @override
  void initState() {
    x = service.lerTarefas(collectionPath: widget.collectionPath);
  }

  void changeFinalizado(Tarefa t, bool finalizado) {
    service.changeItem(t);
    if (finalizado) {
      service.removeItem(t.id, collectionPath: 'todayTasks');
      service.adicionarTarefa(t, 'doneTasks');
    }
    else {
      service.removeItem(t.id, collectionPath: 'doneTasks');
      service.ondeAdicionar(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
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

                if (widget.collectionPath == 'todayTasks') {
                  return ListItem(t, collectionPath: widget.collectionPath, listaColecao: documents,);
                }
                else {
                  return ListItem(t, collectionPath: widget.collectionPath,);
                }
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


