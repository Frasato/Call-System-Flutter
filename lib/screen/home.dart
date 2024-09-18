import 'dart:convert';
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
      print('Error: $e');
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
              inputField(Icons.person, 'Username', _usernameController),
              inputField(Icons.lock, 'Password', _passwordController),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: _validateInput,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryYellow,
                    foregroundColor: Colors.black87,
                    elevation: 0.0,
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container inputField(IconData icon, String label, TextEditingController controller) {
    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          label: Text(label, style: const TextStyle(color: Colors.white),),
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
          prefixIcon: Icon(icon, color: lightGreyColor,),
        ),
      ),
    );
  }
}