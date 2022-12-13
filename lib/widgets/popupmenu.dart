import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_xp_app/services/FirestoreService.dart';
import '../models/tarefa.dart';
import '../providers/tarefas.dart';

class PopUpMenu extends StatefulWidget {
  final String collectionPath;

  PopUpMenu({this.collectionPath = 'allTasks'});

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {

  FirestoreService service = FirestoreService();

  late Stream<List<Tarefa>> x;

  @override
  void initState() {
    x = service.lerTarefas(collectionPath: widget.collectionPath);
    super.initState();
  }

  void moverTodosPraLixeira(List<Tarefa> lista) {
    for (Tarefa t in lista) {
      service.removeItem(t.id);
      service.adicionarTarefa(t, 'removedTasks');
    }
  }

  void marcarTodos(List<Tarefa> lista) {

    void changeFinalizado(Tarefa t, bool finalizado) {
      t.finalizado = finalizado;
      service.changeItem(t, collectionPath: widget.collectionPath);
      if (finalizado) {
        service.removeItem(t.id, collectionPath: 'todayTasks');
        service.adicionarTarefa(t, 'doneTasks');
      }
      else {
        service.removeItem(t.id, collectionPath: 'doneTasks');
        service.ondeAdicionar(t);
      }
    }

    for (Tarefa t in lista) {
      changeFinalizado(t, true);
    }
  }

  void desmarcarTodos(List<Tarefa> lista) {
    void changeFinalizado(Tarefa t, bool finalizado) {
      t.finalizado = finalizado;
      service.changeItem(t, collectionPath: widget.collectionPath);
      if (finalizado) {
        service.removeItem(t.id, collectionPath: 'todayTasks');
        service.adicionarTarefa(t, 'doneTasks');
      }
      else {
        service.removeItem(t.id, collectionPath: 'doneTasks');
        service.ondeAdicionar(t);
      }
    }

    for (Tarefa t in lista) {
      changeFinalizado(t, false);
    }
  }

  void esvaziar(List<Tarefa> lista) {
    for (Tarefa t in lista) {
      service.removeItem(t.id, collectionPath: 'removedTasks');
    }
  }

  void resgatar(List<Tarefa> lista) {
    for (Tarefa t in lista) {
      service.recoverItem(t);
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Tarefa>>(
      stream: x,
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasData){
          final documents = streamSnapshot.data!;
          return PopupMenuButton<int>(
            color: Color(0xFF3E3E3E),
            itemBuilder: (context) => ModalRoute.of(context)?.settings.name == '/removed_tasks_page' ? [
              PopupMenuItem(
                value: 1,
                child: Text('Esvaziar', style: TextStyle(color: Colors.white),),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Resgatar todos', style: TextStyle(color: Colors.white),),
              ),
            ] :
            [
              PopupMenuItem(
                value: 3,
                child: Text('Marcar todos', style: TextStyle(color: Colors.white),),
              ),
              PopupMenuItem(
                value: 4,
                child: Text('Desmarcar todos', style: TextStyle(color: Colors.white),),
              ),
              PopupMenuItem(
                value: 5,
                child: Text('Mover todos p/ lixeira', style: TextStyle(color: Colors.white),),
              ),

            ],
            onSelected: (value) {
              if (value == 1) {
                if (documents.length > 0) {
                  showDialog(context: context, builder: (bCtx) {
                    return AlertDialog(
                      title: const Text(
                          'Todas as tarefas serão excluídas permanentemente.\n\nVocê tem certeza?'),
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
                            setState(() {
                              Navigator.of(bCtx).pop();
                            });
                            esvaziar(documents);
                          },
                          child: Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.of(bCtx).pop();
                            });
                          },
                          child: Text(
                            'Cancelar', style: TextStyle(color: Colors.red),),
                        ),
                      ],
                    );
                  });
                }
              }
              if (value == 2) {
                resgatar(documents);
              }
              if (value == 3) {
                marcarTodos(documents);
              }
              if (value == 4) {
                desmarcarTodos(documents);
              }
              if (value == 5) {
                moverTodosPraLixeira(documents);
              }
            },
          );
        }
        else {
          return Container();
        }

      }
    );
  }
}
