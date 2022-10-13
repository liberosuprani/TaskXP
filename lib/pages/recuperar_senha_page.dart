import 'package:flutter/material.dart';
import 'nova_senha_page.dart';

class RecuperarSenhaPage extends StatelessWidget {
  final String name;

  const RecuperarSenhaPage({
    Key? key,
    required this.name,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Tela de Recuperação de Senha"),
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
              'Recuperação de Senha',
              textAlign: TextAlign.center,
              style:
              TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'E-mail ou Nome de Usuário',
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
                    builder: (context) => const NovaSenhaPage(
                      name: 'senha',
                    )
                  ),
                );
              }),
          ],
        ),
      ),
    ),
  );
}