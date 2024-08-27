import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:math';

class ControleIrrigacao extends StatefulWidget{
  @override
  State<ControleIrrigacao> createState() => _ControleIrrigacaoState();
}

class _ControleIrrigacaoState extends State<ControleIrrigacao> {

  final client = (kIsWeb?
                    MqttBrowserClient('ws://vps51445.publiccloud.com.br', Random().toString()):
                    MqttServerClient('ws://vps51445.publiccloud.com.br', Random().toString()));

  double umidade = 0;
  bool bombaStatus = false;

  Future<bool> conexaoMQTT() async{
    if(client.connectionStatus!.state == MqttConnectionState.connected){
      return true;
    }

    if(client is MqttServerClient) {
      MqttServerClient sClient = client as MqttServerClient;
      sClient.useWebSocket = true;
    }

    client.port = 3000;
    client.onConnected = () =>{
      print("Conectado")
    };

    try{
      await client.connect();
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMessage = c![0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);
        print('Received message:$payload from topic: ${c[0].topic}');
        setState(() {
          umidade = double.parse(payload);
        });
      });
      await client.subscribe("/umidade", MqttQos.atMostOnce);
      return true;
    }on Exception catch(e){
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
        FutureBuilder<bool>(
          future: conexaoMQTT(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              if (snapshot.data == true) {
                return buildPainel();
              }else{
                return Text("Não Conectado.");
              }
            }else{
              return CircularProgressIndicator();
            }
          }
          )
    );
  }

  Widget buildPainel(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text("${(100 * (4095 - umidade)/4095).toStringAsFixed(0) }",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                    )),
                Text(" %",style: TextStyle(
                    fontSize: 20
                ))
          ]),
          Text("Umidade")
        ]
    );
  }
}

/**
 * floatingActionButton: FloatingActionButton(
    onPressed: () {
    final builder = MqttClientPayloadBuilder();
    if(bombaStatus == true){
    builder.addString("0");
    }else{
    builder.addString("1");
    }
    bombaStatus = !bombaStatus;
    client.publishMessage("/comando", MqttQos.atLeastOnce, builder.payload!);
    },
    tooltip: 'Increment',
    child: const Icon(Icons.add),
    ), // This trailing comma makes auto-formatting nicer
 */