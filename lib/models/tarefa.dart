import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefa {
  late String id;
  late String titulo;
  late DateTime data;
  late String descricao;
  late bool finalizado;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.data,
    this.descricao = '',
    this.finalizado = false,
  });

  Tarefa.fromMap(Map<String, dynamic> mapa) {
    id = mapa['id'];
    titulo = mapa['titulo'];
    data = (mapa['data'] as Timestamp).toDate();
    descricao = mapa['descricao'];
    finalizado = mapa['finalizado'];
  }

  Map<String, dynamic> toMap () {
    return {
      'id' : id,
      'titulo' : titulo,
      'data' : Timestamp.fromDate(data),
      'descricao' : descricao,
      'finalizado' : finalizado,
    };
  }

}