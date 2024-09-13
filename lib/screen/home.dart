import 'package:estudando_flutter/constants/color.dart';
import 'package:estudando_flutter/screen/calls.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              inputField(Icons.person, 'Username'),
              inputField(Icons.lock, 'Password'),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> const Calls())
                    );
                  },
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

  Container inputField(IconData icon, String label) {
    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
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