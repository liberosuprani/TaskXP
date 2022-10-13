import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tarefa.dart';

class EditorDeTarefa extends StatefulWidget {

  final Function editarTarefa;
  final Tarefa tarefa;

  EditorDeTarefa(this.editarTarefa, this.tarefa);

  @override
  State<EditorDeTarefa> createState() => _EditorDeTarefaState();
}

class _EditorDeTarefaState extends State<EditorDeTarefa> {

  Future<DateTime> mostraDatePicker(BuildContext context, dataAnterior) async {
    var dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (dataSelecionada == null) {
      return dataAnterior;
    } else {
      return dataSelecionada;
    }
  }

  late final tituloController = TextEditingController(text: widget.tarefa.titulo);
  late final descricaoController = TextEditingController(text: widget.tarefa.descricao);
  late DateTime dataController = widget.tarefa.data;
  late final int? id = widget.tarefa.id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar tarefa'),
      content: SingleChildScrollView(
        child: Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                controller: tituloController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Descrição'),
                controller: descricaoController,
              ),
              SizedBox(height: 40),
              Card(
                color: Colors.white,
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      iconSize: 27,
                      onPressed: () async {
                        var data = await mostraDatePicker(
                            context, dataController);
                        setState(() {
                          dataController = data;
                        });
                      },
                      icon: Icon(Icons.date_range),
                    ),
                    Text(DateFormat('dd/MM').format(dataController),
                      style: TextStyle(color: Colors.black45),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.editarTarefa(
              widget.tarefa,
              tituloController.text,
              dataController,
              descricaoController.text,
              widget.tarefa.finalizado
            );
            setState((){
              Navigator.pop(context);
            });
          },
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: Text('Cancelar', style: TextStyle(color: Colors.red),),
        ),
      ],
    );
  }
}
