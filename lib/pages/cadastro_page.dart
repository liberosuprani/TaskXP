import 'package:flutter/material.dart';
import 'login_page.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPage createState() => _CadastroPage();
}

class _CadastroPage extends State<CadastroPage>{


  Widget buildCadastro(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                )),
          );
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'Criar conta',
          style: TextStyle(
              color: Color(0xff3d85c6),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x663d85c6),
                  Color(0x993d85c6),
                  Color(0xcc3d85c6),
                  Color(0xff3d85c6),
                ])),
        child: SizedBox.expand(

          child: ListView(

            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                'Cadastrar-se',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),

              TextFormField(
                decoration: const InputDecoration(

                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                },

              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),

                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
              ),
              buildCadastro(),
            ],
          ),

        ),

      ),

    );
  }
}