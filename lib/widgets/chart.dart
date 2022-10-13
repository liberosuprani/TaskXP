import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas.dart';
import 'chart_bar.dart';
import '../models/tarefa.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  int totalCompleto(List<Tarefa> lista){
    int resultado = 0;
    for(Tarefa t in lista) {
      if (t.finalizado) {
        resultado++;
      }
    }
    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    final lista = Provider.of<Tarefas>(context).itens;

    return Card(
      margin: const EdgeInsets.all(20),
      color: Colors.grey,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Tarefas completas: ${totalCompleto(lista)}/${lista.length}'),
            const SizedBox(height: 5,),
            Container(color: Colors.black12, width: 80, height: 2,),
            const SizedBox(height: 10,),
            ChartBar(totalCompleto(lista)),
          ],
        ),
      ),
    );
  }
}
