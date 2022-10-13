import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../database/db.dart';
import '../models/tarefa.dart';

class Tarefas with ChangeNotifier {

  late List<Tarefa> _itens = [];
  List<Tarefa> _lixeira = [];

  Tarefas() {
    _initRepository();
  }
  _initRepository() async {
    _itens = await DB.instance.lerTodasTarefas('tarefa');
    _lixeira = await DB.instance.lerTodasTarefas('lixeira');
    notifyListeners();
  }

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

  void adicionarTarefa(String titulo, DateTime data, String descricao){
    final t = Tarefa(titulo: titulo, data: data, descricao: descricao);
    DB.instance.criarTarefa('tarefa', t);
    _itens.add(t);

    notifyListeners();
  }

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
    DB.instance.update('tarefa', compraEditada);

    notifyListeners();
  }

  void moverPraLixeira(Tarefa c) {
    DB.instance.criarTarefa('lixeira', c);
    DB.instance.delete('tarefa', c.id!);
    _lixeira.add(c);
    _itens.remove(c);

    notifyListeners();
  }

  void resgatarTarefa(Tarefa t) {
    DB.instance.criarTarefa('tarefa', t);
    DB.instance.delete('lixeira', t.id!);
    _lixeira.remove(t);
    _itens.add(t);

    notifyListeners();
  }

  void removerTarefa(Tarefa c) {
    DB.instance.delete('lixeira', c.id!);
    _lixeira.remove(c);

    notifyListeners();
  }

  void changeFinalizado(Tarefa c, bool finalizado) {
    c.finalizado = finalizado;
    DB.instance.update('tarefa', c);

    notifyListeners();
  }

}