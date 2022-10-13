import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_xp_app/widgets/my_fab.dart';
import '../providers/tarefas.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final listaData = Provider.of<Tarefas>(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Color(0xFF545454),
          appBar: AppBar(
            backgroundColor: Color(0xFF3E3E3E),
            title: const Text('TaskXP'),
          ),
          drawer: MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              childAspectRatio: 3/2,
              mainAxisSpacing: 15,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                     '/today_tasks_page',
                    );
                  },
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
                              Icon(Icons.today, color: Color(0xFF414746),),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topRight,
                                child: Text(
                                  '${listaData.paraHoje.length}',
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
                                'Hoje',
                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    '/all_tasks_page',
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
                                  '${listaData.itens.length}',
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
                                'Todas',
                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/done_tasks_page',
                    );
                  },
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
                              Icon(Icons.check, color: Color(0xFF414746),),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topRight,
                                child: Text(
                                  '${listaData.lixeira.length}',
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
                                'Concluídas',
                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/removed_tasks_page',
                    );
                  },
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
                              Icon(Icons.delete, color: Color(0xFF414746),),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topRight,
                                child: Text(
                                  '${listaData.lixeira.length}',
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
                                'Lixeira',
                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: const MyFab(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        )
      ),
    );
  }
}

