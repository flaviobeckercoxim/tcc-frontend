import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Agendamento.dart';

class FormAgendamento extends StatefulWidget{
  Agendamento agendamento;
  FormAgendamento(this.agendamento);

  @override
  State<StatefulWidget> createState() {
    return _FormAgendamentoState(agendamento);
  }
}

class _FormAgendamentoState extends State{
  TextEditingController horarioController = TextEditingController();
  TextEditingController tempoController = TextEditingController();
  int diaSelecionado = 1;

  List<DropdownMenuItem> dias = [
    DropdownMenuItem(
      child: Text("Segunda-Feira"),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text("Terça-Feira"),
      value: 2,
    ),
    DropdownMenuItem(
        child: Text("Quarta-Feira"),
        value: 3
    ),
    DropdownMenuItem(
        child: Text("Quinta-Feira"),
        value: 4
    ),
    DropdownMenuItem(
        child: Text("Sexta-Feira"),
        value: 5
    ),
    DropdownMenuItem(
        child: Text("Sábado"),
        value: 6
    ),
    DropdownMenuItem(
        child: Text("Domingo"),
        value: 7
    )
  ];

  final _formKey = GlobalKey<FormState>();

  Agendamento agendamento;
  _FormAgendamentoState(this.agendamento);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text((agendamento.id.compareTo("0") == 0?"Novo Agendamento":"Editar Agendamento"))),
      body: _buildForm(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pop(context);
        }
      ),
    );
  }

  Widget _buildForm(){
    return Form(
        key: _formKey,
        child: Column(
            children:[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText:"Dia",
                        prefixIcon: Icon(Icons.calendar_today)
                    ),
                  items: dias,
                  value: diaSelecionado,
                  onChanged: (value) {
                    setState(() {
                      diaSelecionado = value;
                    });
                  }
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: DateTimePicker(
                  type: DateTimePickerType.time,
                  decoration: InputDecoration(
                      labelText: 'Horário',
                      prefixIcon: Icon(Icons.access_time)
                  ),
                  use24HourFormat: true,
                  initialValue: '',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                )
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child:TextFormField(
                  controller: tempoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Tempo (Minutos)',
                      prefixIcon: Icon(Icons.timer)
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o tempo em minutos.';
                    }
                    return null;
                  },
                )
              )
            ]
        )
    );
  }
}