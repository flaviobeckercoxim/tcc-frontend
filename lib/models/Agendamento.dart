class Agendamento{
  String id;
  int dia;
  DateTime horario;
  int tempo;

  Agendamento(this.id, this.dia, this.horario, this.tempo);

  Agendamento.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String,
        dia = json['dia'] as int,
        horario = DateTime.parse(json['horario']).toLocal(),
        tempo = json['tempo'] as int;

  Map<String, dynamic> toJson() => {
    'id': id,
    'dia': dia,
    'horario': horario.toUtc().toString(),
    'tempo': tempo
  };
}