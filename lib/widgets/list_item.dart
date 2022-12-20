import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_xp_app/services/FirestoreService.dart';
import '../models/tarefa.dart';
import 'editor_de_tarefa.dart';

class ListItem extends StatefulWidget {

  final String collectionPath;
  final Tarefa t;
  final List<Tarefa>? listaColecao;

  ListItem(this.t, {this.collectionPath = 'allTasks', this.listaColecao = null});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {

  FirestoreService db = FirestoreService();

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

  Color corData (Tarefa t, DateTime now){
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
    final now = DateTime.now();
    if (ModalRoute.of(context)?.settings.name != '/removed_tasks_page') {
     return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 15.0),
        child: Card(
          color: Color(0xFF5C5C5E),
          elevation: 7.5,
          child: Slidable(
              startActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction( // MOVER TAREFA PRA LIXEIRA
                    onPressed: (context) {
                      db.adicionarTarefa(widget.t, 'removedTasks');
                      db.removeItem(widget.t.id);
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    flex: 2,
                  ),
                  SlidableAction( // EDITAR TAREFA
                    onPressed: (ctx) {
                      showDialog(context: ctx, builder: (bCtx) {
                        return EditorDeTarefa(widget.t, collectionPath: widget
                            .collectionPath,); //////////////
                      });
                    },
                    icon: Icons.edit,
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
                value: widget.t.finalizado,
                onChanged: (value) {
                  setState(() {
                    widget.t.finalizado = value!;
                    ModalRoute
                        .of(context)
                        ?.settings
                        .name != '/all_tasks_page' ?
                    Future.delayed(const Duration(milliseconds: 350), () {
                      changeFinalizado(widget.t, widget.t.finalizado);
                    })
                        :
                    changeFinalizado(widget.t, widget.t.finalizado);
                  });
                },
                // MUDAR CHECKBOX
                title: Text(
                  widget.t.titulo,
                  style: TextStyle(fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: RichText(
                  text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: widget.t.descricao, style: TextStyle(fontSize: 12.5)),
                        TextSpan(text: widget.t.descricao == '' ? '' : '\n'),
                        TextSpan(text: DateFormat('dd/MM/yyyy').format(widget.t.data),
                          style: TextStyle(fontSize: 12.5, color: corData(widget.t, DateTime.now()),),),
                      ]
                  ),
                ),

              )
          ),
        ),
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 15.0),
        child: Card(
          color: Color(0xFF5C5C5E),
          elevation: 7.5,
          child: Slidable(
            startActionPane: ActionPane(
              motion: DrawerMotion(),
              children: [
                SlidableAction( // RECUPERAR TAREFA
                  onPressed: (context) => db.recoverItem(widget.t),
                  icon: Icons.redo,
                  backgroundColor: Colors.blueGrey,
                  flex: 2,
                ),
                SlidableAction( // EXCLUIR TAREFA
                  onPressed: (context) {
                    showDialog(context: context, builder: (bCtx) {
                      return AlertDialog(
                        title: const Text(
                            'Essa tarefa será excluída permanentemente.\n\nVocê tem certeza?'),
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
                              db.removeItem(collectionPath: 'removedTasks',
                                  widget.t.id); /////////////////
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
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  flex: 2,
                ),
              ],
            ),
            child: ListTile(
              tileColor: Color(0xFF5C5C5E), // MUDAR CHECKBOX
              title: Text(
                widget.t.titulo,
                style: TextStyle(fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: RichText(
                text: TextSpan(
                    children: <TextSpan> [
                      TextSpan(text: widget.t.descricao, style: TextStyle(fontSize: 12.5)),
                      TextSpan(text: widget.t.descricao == '' ? '' : '\n'),
                      TextSpan(text: DateFormat('dd/MM/yyyy').format(widget.t.data),
                        style: TextStyle(fontSize: 12.5, color: corData(widget.t, DateTime.now()),),),
                    ]
                ),
              ),
            ),
          ),
        ),
      );

    }
  }
}
