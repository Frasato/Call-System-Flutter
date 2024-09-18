import 'package:estudando_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
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
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 700,
              child: TextField(
                decoration: InputDecoration(
                  label: const Text('AnyDesk ID', style: TextStyle(color: Colors.white),),
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
                      onPressed: (){
                        Navigator.pop(context);
                      },
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