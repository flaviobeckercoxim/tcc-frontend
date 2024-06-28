class Agendamento{
  String id;
  DateTime diaHorario;
  DateTime tempo;

  Agendamento(this.id, this.diaHorario, this.tempo);

  Agendamento.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        diaHorario = DateTime(json['diaHorario']),
        tempo = DateTime(json['tempo']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'diaHorario': diaHorario,
    'tempo': tempo
  };
}