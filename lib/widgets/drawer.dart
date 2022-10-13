import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF545454),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF3E3E3E)),
              currentAccountPicture: CircleAvatar(
                child: Text('Imagem'),
              ),
              accountName: Text('Nome'),
              accountEmail: Text('nome@gmail.com'),
            ),
            Column(children: [
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text('Home', style: TextStyle(color: Colors.white),),
                onTap: () => Navigator.pushReplacementNamed(context, '/home_page'),
              ),
              ListTile(
                leading: const Icon(Icons.today, color: Colors.white),
                title: const Text('Hoje', style: TextStyle(color: Colors.white),),
                onTap: () {
                  if (!(_scaffoldKey.currentState?.isDrawerOpen == true)){
                    Navigator.of(context).pop();
                  }
                  Navigator.pushNamed(context, '/today_tasks_page');
                },
              ),
              ListTile(
                leading: const Icon(Icons.task, color: Colors.white),
                title: const Text('Todas as tarefas', style: TextStyle(color: Colors.white),),
                onTap: () {
                  if (!(_scaffoldKey.currentState?.isDrawerOpen == true)){
                    Navigator.of(context).pop();
                  }
                  Navigator.pushNamed(context, '/all_tasks_page');
                },
              ),
              ListTile(
                leading: Icon(Icons.hourglass_bottom, color: Colors.white),
                title: Text('Tarefas a fazer', style: TextStyle(color: Colors.white),),
                onTap: () {
                  if (!(_scaffoldKey.currentState?.isDrawerOpen == true)){
                    Navigator.of(context).pop();
                  }
                  Navigator.pushNamed(context, '/todo_tasks_page');
                },
              ),
              ListTile(
                leading: Icon(Icons.task_alt, color: Colors.white),
                title: Text('Tarefas completas', style: TextStyle(color: Colors.white),),
                onTap: () {
                  if (!(_scaffoldKey.currentState?.isDrawerOpen == true)){
                    Navigator.of(context).pop();
                  }
                  Navigator.pushNamed(context, '/done_tasks_page');
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.white),
                title: Text('Lixeira', style: TextStyle(color: Colors.white),),
                onTap: () {
                  if (!(_scaffoldKey.currentState?.isDrawerOpen == true)){
                    Navigator.of(context).pop();
                  }
                  Navigator.pushNamed(context, '/removed_tasks_page');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text('Configurações', style: TextStyle(color: Colors.white),),
              ),
            ],),

          ],
        ),
      ),
    );
  }
}
