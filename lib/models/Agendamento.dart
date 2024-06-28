


class Agendamento{
  String id;
  DateTime diaSemana;
  DateTime horario;
  DateTime tempo;


  Agendamento(this.id, this.diaSemana, this.horario, this.tempo);

  factory Agendamento.fromJson(Map<String, dynamic> json){
    return Agendamento(
        id: json['id'],
        diaSemana: json['diaSemana'],
        horario: json['horario'],
        tempo: json['tempo']
    );
  }
}