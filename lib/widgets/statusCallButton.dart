import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:estudando_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class StatusCallButton extends StatefulWidget {
  final String id;

  const StatusCallButton({super.key, required this.id});

  @override
  State<StatusCallButton> createState() => _StatusCallButtonState();
}

class _StatusCallButtonState extends State<StatusCallButton> {
  late String id;
  String dropDownValue = 'Em Espera';

  var items = [
    'Em Espera',
    'Em Andamento',
    'Pausado',
    'Finalizado',
  ];

  @override
  void initState(){
    super.initState();
    id = widget.id;
  }

  Future<void> changStatus() async{
    final url = Uri.parse('http://localhost:8080/user/status/$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      "status": dropDownValue,
    };

    String jsonBody = jsonEncode(body);

    try{

      final response = await http.put(url, headers: headers, body: jsonBody);

      if(response.statusCode == 200){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Mudança de Estado',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: const Text('Status alterado com sucesso!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(color: greyBackground),
                ),
              ),
            ],
          ),
        );
      }else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Erro',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: const Text('Não conseguimos alterar o status'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(color: greyBackground),
                ),
              ),
            ],
          ),
        );
      }

    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      decoration: const BoxDecoration(
        color: greyBackground
      ),
      child: Column(
        children: [
          DropdownButton(
            padding: const EdgeInsets.only(bottom: 0),
            dropdownColor: greyColor,
            underline: Container(
              height: 1.5,
              color: Colors.white,
            ),
            value: dropDownValue,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,),
            items: items.map((String item){
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: const TextStyle(color: Colors.white),)
              );
            }).toList(),
            onChanged: (String? newValue){
              setState(() {
                dropDownValue = newValue!;
                changStatus();
              });
            },
          )
        ],
      ),
    );
  }
}