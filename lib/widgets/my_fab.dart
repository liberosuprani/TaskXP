import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas.dart';
import 'nova_tarefa.dart';

class MyFab extends StatelessWidget {
  const MyFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listaData = Provider.of<Tarefas>(context);

    return FloatingActionButton(
      child: const Icon(Icons.add),
      backgroundColor: Color(0XFF6B86FF),
      onPressed: () {
        showModalBottomSheet(context: context, builder: (bCtx) {
          return NovaTarefa(listaData.adicionarTarefa);
        });
      },
    );
  }
}
