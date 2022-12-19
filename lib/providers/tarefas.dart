import 'package:flutter/material.dart';
import '../services/FirestoreService.dart';
import '../models/tarefa.dart';



/*
class Tarefas with ChangeNotifier {

  final service = FirestoreService();

  late List<Tarefa> _itens = [];
  late List<Tarefa> _lixeira = [];

  List<Tarefa> get itens {
    return [..._itens];
  }

  List<Tarefa> get concluidas {
    return _itens.where((t) => t.finalizado == true).toList();
  }

  List<Tarefa> get inconcluidas {
    return _itens.where((t) => t.finalizado == false).toList();
  }

  List<Tarefa> get lixeira {
    return [..._lixeira];
  }

  List<Tarefa> get paraHoje {
    return _itens.where((t) {
      final now = DateTime.now();
      if (DateTime(t.data.year, t.data.month, t.data.day).difference(DateTime(now.year, now.month, now.day)).inDays == 0 && t.finalizado == false){
        return true;
      }
      else {
        return false;
      }
    }).toList();
  }

  /*
  void adicionarTarefa(String titulo, DateTime data, String descricao){
    final t = Tarefa(id: itens.length, titulo: titulo, data: data, descricao: descricao);
    service.adicionarTarefa(t, '');
  }

   */

  void editarTarefa(Tarefa t, String titulo, DateTime data, String descricao, bool finalizado) {
    if (t.titulo == titulo && t.data.day == data.day && t.data.month == data.month && t.data.year == data.year && t.finalizado == finalizado) {
      return;
    }
    Tarefa compraEditada = Tarefa(
      titulo: titulo,
      data: data,
      id: t.id,
      finalizado: finalizado,
    );
    _itens.insert(_itens.indexOf(t), compraEditada);
    _itens.remove(t);
    notifyListeners();
  }

  void moverPraLixeira(Tarefa c) {
    //_lixeira.add(c);
    _itens.remove(c);

    notifyListeners();
  }

  void resgatarTarefa(Tarefa t) {
    //_lixeira.remove(t);
    _itens.add(t);

    notifyListeners();
  }

  void removerTarefa(Tarefa c) {
    //_lixeira.remove(c);

    notifyListeners();
  }

  void changeFinalizado(Tarefa c, bool finalizado) {
    c.finalizado = finalizado;

    notifyListeners();
  }

}

 */