import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas.dart';
import '../services/FirestoreService.dart';
import 'package:intl/intl.dart';
import '../models/tarefa.dart';
import 'package:uuid/uuid.dart';

class NovaTarefa extends StatefulWidget {

  @override
  State<NovaTarefa> createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> {

  void ondeAdicionar (Tarefa t) {
    instance.adicionarTarefa(t, 'allTasks');

    final now = DateTime.now();
    if (DateTime(t.data.year, t.data.month, t.data.day).difference(DateTime(now.year, now.month, now.day)).inDays == 0 && t.finalizado == false){
      instance.adicionarTarefa(t, 'todayTasks');
    }
  }

  Future<DateTime> mostraDatePicker(BuildContext context, dataAnterior) async {
    var dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year+7),
    );
    if (dataSelecionada == null) {
      return dataAnterior;
    } else {
      return dataSelecionada;
    }
  }

  FirestoreService instance = FirestoreService();
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  DateTime dataController = DateTime.now();
  String textoErroSemTitulo = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tarefa>>(
      stream: instance.lerTarefas(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasData) {
          final documents = streamSnapshot.data!;
          return Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Título'),
                    controller: tituloController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    controller: descricaoController,
                  ),
                  const SizedBox(height: 10,),
                  Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          iconSize: 27,
                          onPressed: () async {
                            var data = await mostraDatePicker(context, dataController);
                            setState(()  {
                              dataController = data;
                            });
                          },
                          icon: const Icon(Icons.date_range),
                        ),
                        Text(DateFormat('dd/MM').format(dataController), style: const TextStyle(color: Colors.black45),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(textoErroSemTitulo, style: TextStyle(color: Colors.red),),
                      TextButton(
                        onPressed: () {
                          if(tituloController.text.isEmpty){
                            setState((){
                              textoErroSemTitulo = 'Você precisa inserir um título!';
                            });
                            return;
                          }
                          setState((){
                            if(descricaoController == null){
                              descricaoController.text = '';
                            }
                            Tarefa t = Tarefa(
                              id: Uuid().v4(),
                              titulo: tituloController.text,
                              data: dataController,
                              descricao: descricaoController.text,
                            );
                            ondeAdicionar(t);
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Adicionar tarefa', style: TextStyle(color: Colors.blue),),
                      )
                    ],
                  )
                ],
              ),
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
