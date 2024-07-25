import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/models/Agendamento.dart';
import 'package:tcc/services/agendamentoService.dart';
import 'package:tcc/views/FormAgendamento.dart';

class ListViewAgendamentos extends StatefulWidget{
  const ListViewAgendamentos({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ListViewAgendamentosState();
  }
}

class _ListViewAgendamentosState extends State<ListViewAgendamentos>{
  // Armazena todos os agendamentos
  List<Agendamento> agendamentos = [];

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
    String diaDaSemana = getDiaSemana(agendamento.dia);
    String horario = DateFormat('HH:mm').format(agendamento.horario);
    String tempo = agendamento.tempo.toString();
    return ListTile(
      leading: CircleAvatar(child: Text('${diaDaSemana[0]}${diaDaSemana[1]}${diaDaSemana[2]}')),
      title: Text(diaDaSemana),
      subtitle: Text("Horário: ${horario} - Tempo: ${tempo} min."),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(onPressed: ()=>{acaoBotaoEditarAgendamento(agendamento)}, icon: Icon(Icons.edit)),
        IconButton(onPressed: ()=>{acaoBotaoRemover(context, agendamento.id)}, icon: Icon(Icons.delete)),
      ]),
    );
  }

  void acaoBotaoAddAgendamento() async{
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormAgendamento(Agendamento("0", 1, DateTime.now(), 10) as Agendamento))
    );
    setState(() {

    });
  }

  void acaoBotaoEditarAgendamento(Agendamento agendamento) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormAgendamento(agendamento))
    );
    setState(() {

    });
  }

  void acaoBotaoRemover(BuildContext context, String id) {
    Widget cancelButton = TextButton(
      child: Text("Não"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Sim"),
      onPressed:  () async {
        try {
          removerAgendamento(id);
          setState(() {

          });
          Navigator.of(context).pop();
        }catch(e){
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Problema ao remover"),
          ));
          Navigator.of(context).pop();
        }
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Atenção"),
      content: Text("Gostaria mesmo de remover o agendamento?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String getDiaSemana(int dia){
    switch(dia){
      case 1:
        return "Segunda-Feira";
      case 2:
        return "Terça-Feira";
      case 3:
        return "Quarta-Feira";
      case 4:
        return "Quinta-Feira";
      case 5:
        return "Sexta-Feira";
      case 6:
        return "Sábado";
      case 7:
        return "Domingo";
      default:
        return "";
    }
  }
}