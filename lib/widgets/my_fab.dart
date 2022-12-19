import 'package:flutter/material.dart';
import 'nova_tarefa.dart';

class MyFab extends StatelessWidget {
  const MyFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      child: const Icon(Icons.add),
      backgroundColor: Color(0XFF6B86FF),
      onPressed: () {
        showModalBottomSheet(context: context, builder: (bCtx) {
          return NovaTarefa();
        });
      },
    );
  }
}
