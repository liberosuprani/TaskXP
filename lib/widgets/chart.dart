import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_xp_app/services/FirestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/tarefas.dart';
import 'chart_bar.dart';
import '../models/tarefa.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final FirestoreService service = FirestoreService();

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: service.requestCount(collectionPath: 'doneTasks'),
      builder: (context, snapshot1) {
        if(snapshot1.hasData) {
          return StreamBuilder<QuerySnapshot>(
              stream: service.requestCount(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Card(
                    margin: const EdgeInsets.all(20),
                    color: Colors.grey,
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Tarefas completas: ${snapshot1.data?.size.toString() ?? '0'}/${snapshot.data?.size.toString() ?? '0'}'),
                          const SizedBox(height: 5,),
                          Container(color: Colors.black12, width: 80, height: 2,),
                          const SizedBox(height: 10,),
                          ChartBar(snapshot.data?.size, snapshot1.data?.size),
                        ],
                      ),
                    ),
                  );
                }
                else {
                  return Container();
                }
              }
          );
        }
        else {
          return Container();
        }
      },
    );
  }
}
