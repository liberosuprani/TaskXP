import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../models/tarefa.dart';

class FirestoreService {

  FirestoreService._init();
  static final FirestoreService _instance = FirestoreService._init();
  factory FirestoreService() {
    return _instance;
  }

  String? userUid = FirebaseAuth.instance.currentUser?.uid ?? ' ';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> adicionarTarefa(Tarefa tarefa, String collectionPath) {
    return db.collection('users').doc(userUid)
        .collection('tasks').doc('doc').collection(collectionPath).doc(tarefa.id)
        .set(tarefa.toMap());
  }

  Stream<List<Tarefa>> observeToday({String collectionPath = 'todayTasks'}) {

    return db.collection('users').doc(userUid)
        .collection('tasks').doc('doc').collection(collectionPath).snapshots().map((snapshot) =>
        snapshot.docs.map((documento) {
          var agora = Timestamp.fromDate(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day));

          db.collection('users').doc(userUid)
              .collection('tasks').doc('doc').collection('todayTasks').where('data', isLessThan: agora)
              .get().then((value){
            for (var doc in value.docs) {
              var map = doc.data();
              removeItem(map['id'], collectionPath: 'todayTasks');
            }
          });
          return Tarefa.fromMap(documento.data());
        }).toList()
    );
  }

  Stream<List<Tarefa>> lerTarefas({String collectionPath = 'allTasks'}) {

    var agora = Timestamp.fromDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));

    db.collection('users').doc(userUid)
        .collection('tasks').doc('doc').collection('todayTasks').where('data', isLessThan: agora)
    .get().then((value){
      for (var doc in value.docs) {
        var map = doc.data();
        removeItem(map['id'], collectionPath: 'todayTasks');
      }
    });

    return db.collection('users').doc(userUid)
        .collection('tasks').doc('doc').collection(collectionPath).snapshots().map((snapshot) =>
        snapshot.docs.map((documento) => Tarefa.fromMap(documento.data())).toList()
    );
  }

  Future<void> removeItem(String id, {String collectionPath = 'allTasks'}) {
    if(collectionPath == 'allTasks') {
      db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('todayTasks').doc(id).delete();
      db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('doneTasks').doc(id).delete();
      return db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('allTasks').doc(id).delete();
    }
    else {
      return db.collection('users').doc(userUid).collection('tasks').doc('doc').collection(collectionPath).doc(id).delete();
    }
  }

  Future<void> recoverItem(Tarefa t) {
    ondeAdicionar(t);
    return db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('removedTasks').doc(t.id).delete();
  }

  Stream<QuerySnapshot> requestCount({String collectionPath = 'allTasks'}) {
    return db.collection('users').doc(userUid).collection('tasks').doc('doc').collection(collectionPath).snapshots();
  }

  Future<void> changeItem(Tarefa t, {String collectionPath = 'allTasks'}) async {
    FirestoreService service = FirestoreService();


    final now = DateTime.now();
    if (DateTime(t.data.year, t.data.month, t.data.day).difference(DateTime(now.year, now.month, now.day)).inDays == 0 && t.finalizado == false){
      var a = await db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('todayTasks').doc(t.id).get();
      if (a.exists) {
        db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('todayTasks').doc(t.id).update(t.toMap());
      }
      else {
        adicionarTarefa(t, 'todayTasks');
      }
    }
    else if (t.finalizado == false) {
      var a = await db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('todayTasks').doc(t.id).get();
      if (a.exists) {
        removeItem(t.id, collectionPath: 'todayTasks');
        db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('allTasks').doc(t.id).update(t.toMap());
      }
    }
    if (t.finalizado) {
      db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('doneTasks').doc(t.id).update(t.toMap());
    }

    return db.collection('users').doc(userUid).collection('tasks').doc('doc').collection('allTasks').doc(t.id).update(t.toMap());
  }

  void ondeAdicionar (Tarefa t) {
    FirestoreService service = FirestoreService();
    service.adicionarTarefa(t, 'allTasks');

    final now = DateTime.now();
    if (DateTime(t.data.year, t.data.month, t.data.day).difference(DateTime(now.year, now.month, now.day)).inDays == 0 && t.finalizado == false){
      service.adicionarTarefa(t, 'todayTasks');
    }
    if (t.finalizado) {
      service.adicionarTarefa(t, 'doneTasks');
    }
  }
}