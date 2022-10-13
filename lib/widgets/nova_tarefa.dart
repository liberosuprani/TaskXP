import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas.dart';
import './lista_de_tarefas.dart';
import '../models/tarefa.dart';
import 'package:intl/intl.dart';

class NovaTarefa extends StatefulWidget {

  final Function adicionarTarefa;

  NovaTarefa(this.adicionarTarefa);

  @override
  State<NovaTarefa> createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> {

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

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  DateTime dataController = DateTime.now();
  String textoErroSemTitulo = '';

  @override
  Widget build(BuildContext context) {
    final lista = Provider.of<Tarefas>(context).itens;
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
                      widget.adicionarTarefa(tituloController.text, dataController, descricaoController.text);
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
}
