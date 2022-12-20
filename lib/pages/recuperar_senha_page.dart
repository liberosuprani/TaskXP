import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'nova_senha_page.dart';
import 'package:basic_utils/basic_utils.dart';

class RecuperarSenhaPage extends StatefulWidget {

  @override
  State<RecuperarSenhaPage> createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  TextEditingController emailController = TextEditingController();

  String erro = '';

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      erro = 'Link de recuperação enviado ao email';
    } on FirebaseAuthException catch (e) {
      erro = e.message!;
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(


    appBar: AppBar(
      title: const Text("Tela de Recuperação de Senha"),
      centerTitle: true,
      backgroundColor: Color(0xFF3A5FCD),
    ),
    body: Container(
      padding: const EdgeInsets.only(
        top: 60,
        left: 40,
        right: 40,
      ),
      child: SizedBox.expand(
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Recuperação de Senha',
              textAlign: TextAlign.center,
              style:
              TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Redefinir sua senha",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: ((){
                erro = '';
                setState((){
                  resetPassword();
                });
              }),
              style:ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3A5FCD),
              ),
            ),

            Text(erro, style: TextStyle(color: Colors.red, fontSize: 40),)
          ],
        ),
      ),
    ),
  );
}