import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_xp_app/providers/tarefas.dart';
import 'package:task_xp_app/services/FirestoreService.dart';
import 'package:task_xp_app/widgets/my_fab.dart';
import '../models/tarefa.dart';
import '../widgets/folder_widget.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final FirestoreService service = FirestoreService();
    service.userUid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<List<Tarefa>>(
      stream: service.observeToday(),
      builder: (context, snapshot) {
        return SafeArea(
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              backgroundColor: Color(0xFF545454),
              appBar: AppBar(
                backgroundColor: Color(0xFF3E3E3E),
                title: const Text('TaskXP'),
              ),
              drawer: MyDrawer(),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  childAspectRatio: 3/2,
                  mainAxisSpacing: 15,
                  children: [
                    FolderWidget('/today_tasks_page', 'Hoje'),
                    FolderWidget('/all_tasks_page', 'Todas'),
                    FolderWidget('/done_tasks_page', 'Concluídas'),
                    FolderWidget('/removed_tasks_page', 'Lixeira'),
                  ],
                ),
              ),
              floatingActionButton: const MyFab(),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            )
          ),
        );
      }
    );
  }
}

