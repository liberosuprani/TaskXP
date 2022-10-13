class Tarefa {
  late int? id;
  late String titulo;
  late DateTime data;
  late String descricao;
  late bool finalizado;

  Tarefa({
    this.id,
    required this.titulo,
    required this.data,
    this.descricao = '',
    this.finalizado = false,
  });

  Tarefa.fromMap(Map<String, dynamic> mapa) {
    id = mapa['id'];
    titulo = mapa['titulo'];
    data = DateTime.fromMillisecondsSinceEpoch(mapa['data']);
    descricao = mapa['descricao'];
    finalizado = mapa['finalizado'] == 0 ? false : true;
  }

  Map<String, dynamic> toMap () {
    return {
      'id' : id,
      'titulo' : titulo,
      'data' : data.millisecondsSinceEpoch,
      'descricao' : descricao,
      'finalizado' : (finalizado ? 1 : 0),
    };
  }

}