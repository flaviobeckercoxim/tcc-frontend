class Agendamento{
  String id;
  int dia;
  DateTime horario;
  DateTime tempo;

  Agendamento(this.id, this.dia, this.horario, this.tempo);

  Agendamento.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        dia = json['dia'] as int,
        horario = DateTime(json['horario']),
        tempo = DateTime(json['tempo']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'dia': dia,
    'horario': horario.toString(),
    'tempo': tempo.toString()
  };
}