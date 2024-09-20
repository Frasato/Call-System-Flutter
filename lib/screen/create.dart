import 'dart:convert';
import 'package:estudando_flutter/widgets/buttonYellow.dart';
import 'package:estudando_flutter/widgets/inputField.dart';
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

  late String id;
  late String username;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    username = widget.username;
  }

  void _validateInputs() {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    String sector = _sectorController.text.trim();

    if (title.isEmpty || description.isEmpty || sector.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Erro',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: const Text('Por favor, preencha todos os campos.'),
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
    } else {
      createCall(title, description, sector);
    }
  }

  Future<void> createCall(
      String title, String description, String sector) async {
    final url = Uri.parse('http://localhost:8080/user/create/$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'title': title,
      'description': description,
      'whoCalled': username,
      'sector': sector,
    };

    String jsonBody = jsonEncode(body);

    try {
      final response = await http.post(url, headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        throw Exception('Internal server error ${response.statusCode}');
      }
    } catch (e) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(
                  controller: _titleController,
                  icon: Icons.title,
                  label: 'Titulo',
                  widthField: 340,
                  bottomValue: 20,
                  topValue: 0,
                  rightValue: 20,
                ),
                InputField(
                  controller: _sectorController,
                  icon: Icons.business_outlined,
                  label: 'Setor',
                  widthField: 340,
                  bottomValue: 20,
                  topValue: 0,
                  rightValue: 0,
                ),
              ],
            ),
            InputField(
              controller: _descriptionController,
              icon: Icons.short_text,
              label: 'Descrição',
              widthField: 700,
              bottomValue: 20,
              topValue: 0,
              rightValue: 0,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, elevation: 0),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: greyBackground),
                      ),
                    ),
                  ),
                  ButtonYellow(
                    label: 'Create',
                    onPressed: _validateInputs,
                    marginTopValue: 0,
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
