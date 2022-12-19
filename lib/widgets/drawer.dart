import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_xp_app/services/FirestoreService.dart';

class MyDrawer extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String _userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF545454),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: db.collection('users').doc(_userUid).get(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFF3E3E3E)),

                    currentAccountPicture: CircleAvatar(
                      child: Icon(Icons.person),
                    ),

                    accountName: Text('${snapshot.data!['username']}'),
                    accountEmail: Text('${snapshot.data!['email']}'),
                  );
                }
                else {
                  return CircularProgressIndicator();
                }
              }
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
                leading: const Icon(Icons.file_copy_outlined, color: Colors.white),
                title: const Text('Todas as tarefas', style: TextStyle(color: Colors.white),),
                onTap: () {
                  if (!(_scaffoldKey.currentState?.isDrawerOpen == true)){
                    Navigator.of(context).pop();
                  }
                  Navigator.pushNamed(context, '/all_tasks_page');
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
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Sair da conta', style: TextStyle(color: Colors.white),),
                onTap: (){
                  showDialog(context: context, builder: (bCtx) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: const Text('Você tem certeza que deseja sair?'),
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
                                setState(() async {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacementNamed('/login_page');
                                });
                              },
                              child: Text('OK'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() => Navigator.of(context).pop());
                              },
                              child: Text(
                                'Cancelar', style: TextStyle(color: Colors.red),),
                            ),
                          ],
                        );
                      }
                    );
                  });

                },
              ),
            ],),

          ],
        ),
      ),
    );
  }
}
