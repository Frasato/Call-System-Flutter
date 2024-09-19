import 'dart:convert';
import 'package:estudando_flutter/widgets/buttonYellow.dart';
import 'package:estudando_flutter/widgets/inputField.dart';
import 'package:http/http.dart' as http;
import 'package:estudando_flutter/constants/color.dart';
import 'package:estudando_flutter/screen/calls.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String id = '';
  String username = '';
  String role = '';

  void _validateInput(){
    String username = _usernameController.text.trim().toLowerCase();
    String password = _passwordController.text.trim().toLowerCase();
  
    if(username == '' || password == ''){
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
      login(username, password);
    }
  }

  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://localhost:8080/user/login');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };

    String jsonBody = jsonEncode(body);

    try{
      final response = await http.post(url, headers: headers, body: jsonBody);
      if(response.statusCode == 200){

        final responseData = jsonDecode(response.body);

        setState(() {
          id = responseData['userId'];
          username = responseData['username'];
          role = responseData['role'];
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Calls(id: id, role: role, username: username)
          )
        );

      }else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro', style: TextStyle(fontWeight: FontWeight.w600),),
            content: const Text('Usuário ou senha incorreto!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK', style: TextStyle(color: greyBackground),),
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
    return Scaffold(
      backgroundColor: greyBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 100,
                ),
              ),
              InputField(controller: _usernameController, icon: Icons.person, label: 'Username', widthField: 400, bottomValue: 5, topValue: 5, rightValue: 0,),
              InputField(controller: _passwordController, icon: Icons.lock, label: 'Password', widthField: 400, bottomValue: 5, topValue: 5, rightValue: 0,),
              ButtonYellow(
                label: 'Login',
                onPressed: _validateInput,
                marginTopValue: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}