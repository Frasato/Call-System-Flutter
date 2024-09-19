import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:estudando_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  final String id;
  final String username;

  const Create({super.key, required this.id, required this.username});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  late String id;
  late String username;

  @override
  void initState(){
    super.initState();
    id = widget.id;
    username = widget.username;
  }

  void _validateInputs(){
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    String sector = _sectorController.text.trim();
    String city = _cityController.text.trim();

    if(title.isEmpty || description.isEmpty || sector.isEmpty || city.isEmpty){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro', style: TextStyle(fontWeight: FontWeight.w600),),
          content: const Text('Por favor, preencha todos os campos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: greyBackground),),
            ),
          ],
        ),
      );
    }else{
      createCall(title, description, sector, city);
    }
  }

  Future<void> createCall(String title, String description, String sector, String city) async{
    final url = Uri.parse('http://localhost:8080/user/create/$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'title': title,
      'description': description,
      'whoCalled': username,
      'sector': sector,
      'city': city
    };

    String jsonBody = jsonEncode(body);

    try{

      final response = await http.post(url, headers: headers, body: jsonBody);
      
      if(response.statusCode == 200){
        Navigator.pop(context);
      }else{
        throw Exception('Internal server error ${response.statusCode}');
      }

    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 700,
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: const Text('Problem Name', style: TextStyle(color: Colors.white),),
                  fillColor: greyColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2.0,
                      color: primaryYellow,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 700,
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  label: const Text('Description', style: TextStyle(color: Colors.white),),
                  fillColor: greyColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2.0,
                      color: primaryYellow,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 340,
                  child: TextField(
                    controller: _sectorController,
                    decoration: InputDecoration(
                      label: const Text('Sector', style: TextStyle(color: Colors.white),),
                      fillColor: greyColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: primaryYellow,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, left: 20),
                  width: 340,
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      label: const Text('City', style: const TextStyle(color: Colors.white),),
                      fillColor: greyColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: primaryYellow,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ),
              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0
                      ),
                      child: const Text('Cancel', style: TextStyle(color: greyBackground),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      onPressed: _validateInputs,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryYellow,
                        elevation: 0
                      ),
                      child: const Text('Create', style: TextStyle(color: greyBackground),),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}