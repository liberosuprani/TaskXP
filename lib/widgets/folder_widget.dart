import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_xp_app/services/FirestoreService.dart';

class FolderWidget extends StatefulWidget {

  String pagePath;
  String titulo;

  FolderWidget(this.pagePath, this.titulo);

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {

  final FirestoreService service = FirestoreService();
  String lengthPath = '';


  @override
  Widget build(BuildContext context) {

    if (widget.pagePath == '/all_tasks_page'){
      lengthPath = 'allTasks';
    }
    if (widget.pagePath == '/today_tasks_page'){
      lengthPath = 'todayTasks';
    }
    if (widget.pagePath == '/done_tasks_page'){
      lengthPath = 'doneTasks';
    }
    if (widget.pagePath == '/removed_tasks_page'){
      lengthPath = 'removedTasks';
    }

    return StreamBuilder<QuerySnapshot>(
        stream: service.requestCount(collectionPath: lengthPath),
        builder: (context, snapshot) {
          return InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              '${widget.pagePath}',
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 8, color: Color(0xFF6178DF)),
                color: Color(0xFF6B86FF),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.file_copy_outlined, color: Color(0xFF414746),),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topRight,
                          child: Text(
                            '${snapshot.data?.size.toString() ?? '0'}', // FALTA AQUI
                            style: TextStyle(color: Color(0xFF414746), fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '${widget.titulo}',
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
