import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPage createState() => _CadastroPage();
}

class _CadastroPage extends State<CadastroPage>{

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  String emailValidator = '';
  String senhaValidator = '';
  String confirmarSenhaValidator = '';

  String? mensagem = '';

  bool validator() {
    bool ok = true;
    if (senhaController.text != confirmarSenhaController.text) {
      mensagem = 'As senhas não são iguais';
      ok = false;
    }
    if (senhaController.text.isEmpty || senhaController.text.length < 6 ) {
      senhaValidator = 'A senha deve ter pelo menos 6 caracteres';
      ok = false;
    }
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      mensagem = 'Email inválido';
      ok = false;
    }
    if (nomeController.text.isEmpty) {
      mensagem = 'Insira um nome';
      ok = false;
    }
    return ok;
  }

  final _auth = FirebaseAuth.instance;
  void _submitForm(String nome, String email, String senha) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'username' : nome,
        'email' : email,
      });
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-exists') {
        setState(() {
          mensagem = 'Esse email já está em uso';
        });
      }
    }
    catch (e) {
      print(e);
    }
  }

  Widget buildCadastro(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          emailValidator = '';
          senhaValidator = '';
          confirmarSenhaValidator = '';
          mensagem = '';
          if(!validator()) {
            setState((){});
          }
          else {
            setState((){
              _submitForm(nomeController.text.trim(), emailController.text.trim(), senhaController.text.trim());
            });
          }
        },
        style:ElevatedButton.styleFrom(
          primary: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'Criar conta',
          style: TextStyle(
              color: Color(0xffffffff),
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
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: senhaController,
                obscureText: _showPassword == false ? true : false,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                      child: Icon(_showPassword == false? Icons.visibility_off: Icons.visibility, color: Colors.black26),
                      onTap: () {
                        setState((){
                          _showPassword = !_showPassword;
                        });
                      }
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: confirmarSenhaController,
                obscureText: _showConfirmPassword == false ? true : false,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                      child: Icon(_showConfirmPassword == false? Icons.visibility_off: Icons.visibility, color: Colors.black26),
                      onTap: () {
                        setState((){
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      }
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(mensagem!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 20,),
              buildCadastro(),
            ],
          ),

        ),

      ),

    );
  }
}