import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/Agendamento.dart';

const URL = 'vps51445.publiccloud.com.br:3000';

Future<Agendamento> buscarAgendamentoPorId(int id) async{
  final response = await http.get(Uri.http(URL, '/services/agendamento/$id'));
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
  final response = await http.get(Uri.http(URL, '/services/agendamento'));
  if(response.statusCode == 200){
    final utf8Json = utf8.decode(response.bodyBytes);
    return compute(parseAgendamentos, utf8Json);
  }else{
    throw Exception(response.body);
  }
}

List<Agendamento> parseAgendamentos(String responseBody){
  final mapAgendamentos = jsonDecode(responseBody);
  try {
    return mapAgendamentos.map<Agendamento>((mapJson) {
      return Agendamento.fromJson(mapJson);
    }).toList();
  }catch(e){
    print(e);
    return [];
  }
}

Future<void> salvarAgendamento(Agendamento agendamento) async{
  final response = await http.post(Uri.http(URL, '/services/agendamento'),
      headers: <String,String>{
        'Content-Type':'application/json'
      },
      body: jsonEncode(agendamento.toJson())
  );

  if (response.statusCode != 200){
    throw Exception(response.body);
  }
}

Future<void> atualizarAgendamento(Agendamento agendamento) async{
  final response = await http.put(Uri.http(URL, '/services/agendamento'),
      headers: <String,String>{
        'Content-Type':'application/json'
      },
      body: jsonEncode(agendamento.toJson())
  );
  if (response.statusCode != 200){
    throw Exception(response.body);
  }
}

Future<void> removerAgendamento(String id) async{
  final response = await http.delete(Uri.http(URL, '/services/agendamento/$id'));
  if(response.statusCode != 200){
    throw Exception(response.body);
  }
}