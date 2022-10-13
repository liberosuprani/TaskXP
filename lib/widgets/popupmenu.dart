import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../providers/tarefas.dart';

class PopUpMenu extends StatefulWidget {
  final List<Tarefa> lista;

  PopUpMenu(this.lista);

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {

  void moverTodosPraLixeira(List<Tarefa> lista, Function remover) {
    for (Tarefa t in lista) {
      remover(t);
    }
  }

  void marcarTodos(List<Tarefa> lista, Function marcar) {
    for (Tarefa t in lista) {
      marcar(t, true);
    }
  }

  void esvaziar(List<Tarefa> lista, Function remover) {
    for (Tarefa t in lista) {
      remover(t);
    }
  }

  void resgatar(List<Tarefa> lista, Function resgatar) {
    for (Tarefa t in lista) {
      resgatar(t);
    }
  }

  @override
  Widget build(BuildContext context) {

    final listaData = Provider.of<Tarefas>(context);

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
          child: Text('Mover todos p/ lixeira', style: TextStyle(color: Colors.white),),
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          esvaziar(widget.lista, listaData.removerTarefa);
        }
        if (value == 2) {
          resgatar(widget.lista, listaData.resgatarTarefa);
        }
        if (value == 3) {
          marcarTodos(widget.lista, listaData.changeFinalizado);
        }
        if (value == 4) {
          moverTodosPraLixeira(widget.lista, listaData.moverPraLixeira);
        }
      },
    );
  }
}
