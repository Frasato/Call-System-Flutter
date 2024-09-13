import 'package:estudando_flutter/constants/color.dart';
import 'package:estudando_flutter/models/call.dart';
import 'package:flutter/material.dart';

class Calls extends StatefulWidget {
  const Calls({super.key});

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {

  List<Call> calls = [
    Call(
      'Problema na impressora',
      'Whatsapp | Bebedouro',
      'Estou tentando imprimir uma nota fiscal, porém, ela não sai e aparece um erro na tela, "trocar toner".',
      '13/09/2024 9:26:45',
      '1200394192'
    ),
    Call(
      'Tela azul',
      'Balcão | Severínia',
      'Acabei e ligar o computador e ele está com uma tela azul.',
      '12/09/2024 10:43:02',
      '1304395782'
    ),
  ];

  Call? selectedCall;

  void selected(Call call){
    setState(() {
      selectedCall = call;
    });
  }

  void finishCall(){
    if(selectedCall != null){
      setState(() {
        calls.remove(selectedCall);
        selectedCall = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: lightGreyColor,
                    width: 0.5
                  )
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50,left: 20 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: const Image(image: AssetImage('assets/images/logo.png'), height: 50,)
                    ),
                    ...calls.map((call) => GestureDetector(
                      onTap: () => selected(call),
                      child: buildCallItem(call.title, call.subtitle, call.time),
                    )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: selectedCall == null 
                ? const Center(
                  child: Text('Selecione um chamado para ver os detalhes...',style: TextStyle(color: Colors.white),),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedCall!.title, style: const TextStyle(color: primaryYellow, fontSize: 30, fontWeight: FontWeight.bold),),
                    Text(selectedCall!.subtitle, style: const TextStyle(color: lightGreyColor, fontSize: 16),),
                    const SizedBox(height: 20),
                    Text(selectedCall!.details, style: const TextStyle(color: Colors.white, fontSize: 16),),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: finishCall,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryYellow,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Finish')
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildCallItem(String title, String subtitle, String time){
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 18),),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14),),
            Text(time, style: const TextStyle(color: Colors.grey, fontSize: 14),)
          ],
        ),
      ],
    ),
  );
}