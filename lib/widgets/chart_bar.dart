import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../providers/tarefas.dart';

class ChartBar extends StatefulWidget {

  final int? totalGeral;
  final int? totalCompleto;


  ChartBar(this.totalGeral, this.totalCompleto);

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {

  @override

  Widget build(BuildContext context) {
    final tamanhoLista = widget.totalGeral;
    double tamanhoBarra;
    double tamanhoTotalBarra = 300;
    double porcentagem = 0;
    if (widget.totalCompleto == 0)
      tamanhoBarra = 0;
    else {
      tamanhoBarra = (widget.totalCompleto! * tamanhoTotalBarra) / tamanhoLista!;
      porcentagem = (widget.totalCompleto! * 100) / tamanhoLista;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            width: tamanhoTotalBarra,
            height: 10,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Colors.blueGrey,border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: tamanhoBarra,
              height: 10,
              decoration: BoxDecoration(color: Color(0xFF003A6C), borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
        const SizedBox(width: 10,),
        Text('${porcentagem.toStringAsFixed(0)}%'),
      ],
    );
  }
}
