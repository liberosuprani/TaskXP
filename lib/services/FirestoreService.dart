import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tarefa.dart';

class FirestoreService {

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> adicionarTarefa(Tarefa tarefa, String collectionPath) {
    return db
        .collection('tasks').doc('doc').collection(collectionPath).doc(tarefa.id)
        .set(tarefa.toMap());
  }

  Stream<List<Tarefa>> lerTarefas({String collectionPath = 'allTasks'}) {
    return db
        .collection('tasks').doc('doc').collection(collectionPath).snapshots().map((snapshot) =>
        snapshot.docs.map((documento) => Tarefa.fromMap(documento.data())).toList()
    );
  }

  Future<void> removeItem(String id, {String collectionPath = 'allTasks'}) {
    if(collectionPath == 'allTasks') {
      db.collection('tasks').doc('doc').collection('todayTasks').doc(id).delete();
      db.collection('tasks').doc('doc').collection('doneTasks').doc(id).delete();
      return db.collection('tasks').doc('doc').collection('allTasks').doc(id).delete();
    }
    else {
      return db.collection('tasks').doc('doc').collection(collectionPath).doc(id).delete();
    }
  }

  Future<void> recoverItem(Tarefa t) {
    ondeAdicionar(t);
    return db.collection('tasks').doc('doc').collection('removedTasks').doc(t.id).delete();
  }

  Stream<QuerySnapshot> requestCount({String collectionPath = 'allTasks'}) {
    return db.collection('tasks').doc('doc').collection(collectionPath).snapshots();
  }

  Future<void> changeItem(Tarefa t, {String collectionPath = 'allTasks'}) {
    FirestoreService service = FirestoreService();

    final now = DateTime.now();
    if (DateTime(t.data.year, t.data.month, t.data.day).difference(DateTime(now.year, now.month, now.day)).inDays == 0 && t.finalizado == false){
      db.collection('tasks').doc('doc').collection('todayTasks').doc(t.id).update(t.toMap());
    }
    if (t.finalizado) {
      db.collection('tasks').doc('doc').collection('doneTasks').doc(t.id).update(t.toMap());
    }

    return db.collection('tasks').doc('doc').collection('allTasks').doc(t.id).update(t.toMap());
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