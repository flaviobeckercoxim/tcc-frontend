import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/services/agendamentoService.dart';
import 'package:tcc/views/FormAgendamento.dart';
import '../models/Agendamento.dart';

class ListViewAgendamentos extends StatefulWidget{
  const ListViewAgendamentos({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ListViewAgendamentosState();
  }
}

class _ListViewAgendamentosState extends State<ListViewAgendamentos>{
  // Armazena todos os agendamentos
  List<Agendamento> agendamentos = [Agendamento("", DateTime.now(), DateTime.now())];

  @override
  Widget build(BuildContext context) {
    // Constrói o componente ListView
     return Scaffold(
       body:_buildFuture(),
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add),
         onPressed: acaoBotaoAddAgendamento,
       ),
     );
  }

  Widget _buildFuture() {
    return FutureBuilder(
        future: listarAgendamentos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            this.agendamentos = snapshot.data as List<Agendamento>;
            return ListView.builder(
                itemCount: agendamentos.length,
                itemBuilder: itemBuilder,
                shrinkWrap: true
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  // Constrói cada item do ListView
  Widget itemBuilder(BuildContext context, int index){
    Agendamento agendamento = agendamentos[index];
    String diaDaSemana = DateFormat('EEEE').format(agendamento.diaHorario);
    String horario = DateFormat('hh:mm').format(agendamento.diaHorario);
    String tempo = DateFormat('hh:mm').format(agendamento.tempo);
    return ListTile(
      leading: CircleAvatar(child: Text(diaDaSemana[0])),
      title: Text(diaDaSemana),
      subtitle: Text("Horário: ${horario} - Tempo: ${tempo}"),
    );
  }

  void acaoBotaoAddAgendamento(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormAgendamento(Agendamento("0",DateTime.now(), DateTime.now()))),
    );
  }
}