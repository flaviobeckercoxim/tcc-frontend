import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/Agendamento.dart';

const URL = '';

Future<Agendamento> buscarAgendamentoPorId(int id) async{
  final response = await http.get(Uri.https(URL, 'ws/agendamento/$id'));
  if(response.statusCode == 200){
    final utf8Json = utf8.decode(response.bodyBytes);
    Map<String, dynamic> mapAgendamento = jsonDecode(utf8Json);
    Agendamento agendamento = Agendamento.fromJson(mapAgendamento);
    return agendamento;
  }else{
    throw Exception(response.body);
  }
}

Future<List<Agendamento>> listarAgendamentos() async{
  final response = await http.get(Uri.https(URL, 'ws/agendamento'));
  if(response.statusCode == 200){
    final utf8Json = utf8.decode(response.bodyBytes);
    return compute(parseAgendamentos, utf8Json);
  }else{
    throw Exception(response.body);
  }
}

List<Agendamento> parseAgendamentos(String responseBody){
  final mapAgendamentos = jsonDecode(responseBody);
  return mapAgendamentos.map<Agendamento>((mapJson){
    return Agendamento.fromJson(mapJson);
  }).toList();
}

Future<void> salvarAgendamento(Agendamento) async{
  final response = await http.post(Uri.https(URL, 'ws/agendamento'),
      headers: <String,String>{
        'Content-Type':'application/json'
      },
      body: jsonEncode(Agendamento.toJson())
  );

  if (response.statusCode != 200){
    throw Exception(response.body);
  }
}