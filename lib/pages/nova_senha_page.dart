import 'package:flutter/material.dart';
import 'recuperar_senha_page.dart';
import 'login_page.dart';

class NovaSenhaPage extends StatelessWidget {
  final String name;

  const NovaSenhaPage({
    Key? key,
    required this.name,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Tela de Recuperação de Senha"),
      centerTitle: true,
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
              'ALTERAR SENHA DE ACESSO',
              textAlign: TextAlign.left,
              style:
              TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Preencha os dados para efetuar a troca da senha',
              textAlign: TextAlign.left,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nova Senha',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar nova senha',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
              },
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
                      color: Colors.white,              //LOGINNNNNNNNNNNNNN
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage()
                  ),
                );
              }
            ),
          ],
        ),
      ),
    ),
  );
}