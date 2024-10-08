import 'package:estudando_flutter/constants/color.dart';
import 'package:estudando_flutter/models/call.dart';
import 'package:estudando_flutter/screen/create.dart';
import 'package:estudando_flutter/widgets/callItem.dart';
import 'package:estudando_flutter/widgets/item.dart';
import 'package:estudando_flutter/widgets/logoutButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Calls extends StatefulWidget {
  final String role;
  final String id;
  final String username;

  const Calls(
      {super.key,
      required this.id,
      required this.role,
      required this.username});

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  late String id;
  late String role;
  late String username;

  String callId = '';
  String creationDate = '';
  String description = '';
  String sector = '';
  String title = '';
  String whoCalled = '';
  String userId = '';
  String callStatus = '';

  List<Call> calls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    role = widget.role;
    id = widget.id;
    username = widget.username;

    fetchCalls();
  }

  Call? selectedCall;

  Future<void> fetchCalls() async {
    try {
      if (role == 'ADMIN') {
        final url = Uri.parse('http://localhost:8080/user/all');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final utf8Data = utf8.decode(response.bodyBytes);
          final List<dynamic> responseData = jsonDecode(utf8Data);
          List<Call> fetchedCalls = [];

          for (var callData in responseData) {
            Call call = Call(
              callData['title'],
              callData['creationDate'],
              callData['description'],
              callData['id'],
              callData['whoCalled'],
              callData['sector'],
              callData['callStatus']
            );

            fetchedCalls.add(call);
          }

          setState(() {
            calls = fetchedCalls;
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load calls');
        }
      } else {
        final url = Uri.parse('http://localhost:8080/user/user/$id');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final utf8Data = utf8.decode(response.bodyBytes);
          final List<dynamic> responseData = jsonDecode(utf8Data);
          List<Call> fetchedCalls = [];

          for (var callData in responseData) {
            Call call = Call(
              callData['title'],
              callData['creationDate'],
              callData['description'],
              callData['id'],
              callData['whoCalled'],
              callData['sector'],
              callData['callStatus']
            );

            fetchedCalls.add(call);
          }

          setState(() {
            calls = fetchedCalls;
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load calls');
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception(e);
    }
  }

  Future<void> deleteCall() async {
    final url = Uri.parse('http://localhost:8080/user/delete/$callId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'title': title,
      'description': description,
      'sector': sector,
      'whoCalled': whoCalled,
      'creationDate': creationDate,
    };

    String jsonBody = jsonEncode(body);

    try {
      final response = await http.post(url, headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Boa!',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: const Text('Chamado deletado com sucesso!'),
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
        throw Exception('Error on delete call');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void selected(Call call) {
    setState(() {
      selectedCall = call;
      callId = call.id;
      title = call.title;
      sector = call.sector;
      whoCalled = call.whoCalled;
      creationDate = call.creationDate;
      description = call.description;
      callStatus = call.status;
    });
  }

  void finishCall() {
    if (selectedCall != null) {
      deleteCall();

      setState(() {
        calls.remove(selectedCall);
        selectedCall = null;
        callId = '';
        title = '';
        sector = '';
        whoCalled = '';
        creationDate = '';
        description = '';
        callStatus = '';
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
                      right: BorderSide(color: lightGreyColor, width: 0.5))),
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        child: const Image(
                          image: AssetImage('assets/images/logo.png'),
                          height: 50,
                        )),
                    ...calls.map((call) => GestureDetector(
                          onTap: () => selected(call),
                          child: CallItem(
                              title: call.title,
                              username: call.whoCalled,
                              time: call.creationDate,
                              role: role),
                        )),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: primaryYellow,
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Create(
                                    id: id,
                                    username: username,
                                  ),
                                ),
                              );

                              if (result == true) {
                                fetchCalls();
                              }
                            },
                            icon: const Icon(Icons.add),
                            color: greyBackground,
                            iconSize: 20,
                          ),
                        ),
                        const LogoutButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                margin:
                    const EdgeInsets.only(left: 50, top: 50, right: 50, bottom: 30),
                child: selectedCall == null
                    ? const Center(
                        child: Text(
                          'Selecione um chamado para ver os detalhes...',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Item(
                        title: title,
                        description: description,
                        sector: sector,
                        whoCalled: whoCalled,
                        role: role,
                        time: creationDate,
                        id: callId,
                        callStatus: callStatus,
                        onPressed: finishCall
                      )),
          ),
        ],
      ),
    );
  }
}
