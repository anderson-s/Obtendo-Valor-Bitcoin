import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _resultado = 125770.43;
  late Map<String, dynamic> retorno;
  _atualizar() async{
    String _url = "https://blockchain.info/ticker";
    http.Response response;

    response = await http.get(Uri.parse(_url));
    
    // print(response.body);
    setState(() {
      retorno = json.decode(response.body); //Decodificando o retorno
      _resultado = double.parse(retorno["BRL"]["buy"].toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/imagens/bitcoin.png"),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "R\$ $_resultado",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.orange,
                  ),
                ),
                onPressed: () {
                  _atualizar();
                },
                child: const Text(
                  "Atualizar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
