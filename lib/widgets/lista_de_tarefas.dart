import 'package:flutter/material.dart';
import 'package:task_xp_app/providers/tarefas.dart';
import '../models/tarefa.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './editor_de_tarefa.dart';
import './nova_tarefa.dart';
import 'package:provider/provider.dart';

class ListaDeTarefas extends StatefulWidget {

  List<Tarefa> lista;

  ListaDeTarefas(this.lista);

  @override
  State<ListaDeTarefas> createState() => _ListaDeTarefasState();
}

class _ListaDeTarefasState extends State<ListaDeTarefas> {

  @override
  Widget build(BuildContext context) {

    final tarefasData = Provider.of<Tarefas>(context);
    final editarTarefa = tarefasData.editarTarefa;
    final moverPraLixeira = tarefasData.moverPraLixeira;
    final changeFinalizado = tarefasData.changeFinalizado;
    final recuperarTarefa = tarefasData.resgatarTarefa;
    final excluirTarefa = tarefasData.removerTarefa;

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

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.lista.length+1,
        itemBuilder: (ctx, indice) {
          if (indice == widget.lista.length){
            return SizedBox(height: 80,);
          }
          var t = widget.lista[indice];
          return ModalRoute.of(context)?.settings.name != '/removed_tasks_page' ?
             Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 15.0),
                child: Card(
                  color: Color(0xFF5C5C5E),
                  elevation: 7.5,
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(  // DELETAR TAREFA
                          onPressed: (context) => moverPraLixeira(widget.lista[indice]),
                          icon: Icons.delete,
                          //label: 'Deletar',
                          backgroundColor: Colors.red,
                          flex: 2,
                        ),
                        SlidableAction(  // EDITAR TAREFA
                          onPressed: (context) {
                            showDialog(context: context, builder: (bCtx) {
                              return EditorDeTarefa(editarTarefa, widget.lista[indice]);
                            });
                          },
                          icon: Icons.more_horiz,
                          backgroundColor: Colors.blueGrey,
                          flex: 2,
                        ),
                      ],
                    ),
                    child: CheckboxListTile(
                      tileColor: Color(0xFF5C5C5E),
                      checkColor: Color(0xFF003A6C),
                      activeColor: Color(0xFF003A6C),
                      controlAffinity: ListTileControlAffinity.leading,
                      checkboxShape: CircleBorder(),
                      value: t.finalizado,
                      onChanged: (value){
                        setState((){
                          t.finalizado = value!;
                        });
                        Future.delayed(const Duration(milliseconds: 600), () {
                          changeFinalizado(t, value!);
                        });
                      }, // MUDAR CHECKBOX
                      title: Text(
                        t.titulo,
                        style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat('dd/MM/yyyy').format(t.data),
                        style: TextStyle(fontSize: 12.5, color: corData(t),),
                      ),
                    ),
                  ),
                ),
              )
            :
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 15.0),
            child: Card(
              color: Color(0xFF5C5C5E),
              elevation: 7.5,
              child: Slidable(
                startActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(  // RECUPERAR TAREFA
                      onPressed: (context) => recuperarTarefa(t),
                      icon: Icons.redo,
                      backgroundColor: Colors.blueGrey,
                      flex: 2,
                    ),
                    SlidableAction(  // EXCLUIR TAREFA
                      onPressed: (context) {
                        showDialog(context: context, builder: (bCtx) {
                          return AlertDialog(
                            title: const Text('Essa tarefa será excluída permanentemente.\n\nVocê tem certeza?'),
                            content: SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                ),
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.start,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState((){
                                    Navigator.of(bCtx).pop();
                                  });
                                  excluirTarefa(t);
                                },
                                child: Text('OK'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(bCtx).pop();
                                  });
                                },
                                child: Text('Cancelar', style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          );
                        });

                      },
                      icon: Icons.delete,
                      //label: 'Deletar',
                      backgroundColor: Colors.red,
                      flex: 2,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Color(0xFF5C5C5E), // MUDAR CHECKBOX
                  title: Text(
                    t.titulo,
                    style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat('dd/MM/yyyy').format(t.data),
                    style: TextStyle(fontSize: 12.5, color: corData(t),),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

