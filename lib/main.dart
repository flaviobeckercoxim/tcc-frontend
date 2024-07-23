import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:tcc/views/ControleIrrigacao.dart';
import 'package:tcc/views/ListViewAgendamentos.dart';

const String titulo = 'TCC do BECKER';

void main () {
    initializeDateFormatting('pt_br');
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      title: titulo,
      home: ViewNavigation()
    );
  }
}

class ViewNavigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ViewNavigationState();
  }
}

class _ViewNavigationState extends State<ViewNavigation>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(titulo),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.percent),
                  text: "Controle Irrigação",
                ),
                Tab(
                  icon: Icon(Icons.schedule),
                  text: "Angendamentos",
                )
              ]
            )
          ),
          body: TabBarView(
            children: <Widget>[
              ControleIrrigacao(),
              ListViewAgendamentos()
            ]
          )
      )
    );
  }
}


