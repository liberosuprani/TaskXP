import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/FirestoreService.dart';
import 'cadastro_page.dart';
import 'recuperar_senha_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _showPassword = false;
  bool _isLogin = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  String emailValidator = '';
  String senhaValidator = '';

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'E-mail',
          style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]
          ),
          height: 60,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xff3d85c6),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.black38)
            ),

          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '\nSenha',
          style: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]
          ),
          height: 60,
          child: TextField(
            controller: senhaController,
            obscureText: _showPassword == false ? true : false,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: const Icon(
                Icons.lock,
                color: Color(0xff3d85c6),
              ),
              suffixIcon:GestureDetector(
                child: Icon(_showPassword == false? Icons.visibility_off: Icons.visibility, color: Colors.black26),
                onTap: () {
                  setState((){
                    _showPassword = !_showPassword;
                  });
                }
              ),
              hintText: 'Senha',
              hintStyle: const TextStyle(color: Colors.black38)
            ),
          )
        ),
      ],
    );
  }

  Widget buildForgetPassword(){
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/forgot_password');
        },
        child: const Text(
          'Esqueceu a senha?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget buildRememberAC(){
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.blueAccent,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Lembrar-se',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  bool validator() {
    bool ok = true;
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      emailValidator = 'Email válido';
      ok = false;
    }
    if (senhaController.text.isEmpty || senhaController.text.length < 6 ) {
      senhaValidator = 'Senha inválida';
      ok = false;
    }
    return ok;
  }

  final _auth = FirebaseAuth.instance;

  String? mensagem = '';

  void _submitForm(String email, String senha) async {
    try {
      UserCredential userCredential;
      userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: senhaController.text);
      Navigator.of(context).pushNamed(
          '/home_page');
    }  on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (BuildContext bContext) {
              return AlertDialog(
                title: Text("Erro de autenticação"),
                content: Text("Esse usuário não existe."),
                actions: <Widget>[
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("Voltar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              );
            });
      } else if (error.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (BuildContext bContext) {
              return AlertDialog(
                title: Text("Erro de autenticação"),
                content: Text("Senha incorreta"),
                actions: <Widget>[
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("Voltar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              );
            });
      }
    }
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          emailValidator = '';
          senhaValidator = '';
          mensagem = '';
          if(!validator()) {
            setState((){});
          }
          else {
            setState((){
              emailValidator = '';
              senhaValidator = '';
              mensagem = '';
              _submitForm(emailController.text.trim(), senhaController.text.trim());
            });
          }
        },
        style:ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget buildCadastro(){
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CadastroPage(
                )
            ),
          );
        },
        child: const Text(
          'Criar uma conta',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    FirestoreService().userUid = ' ';
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x663d85c6),
                    Color(0x993d85c6),
                    Color(0xcc3d85c6),
                    Color(0xff3d85c6),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'TaskXP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 50),
                    buildEmail(),
                    buildPassword(),
                    buildForgetPassword(),
                    Text(emailValidator, style: TextStyle(color: Colors.red),),
                    Text(senhaValidator, style: TextStyle(color: Colors.red),),
                    // buildRememberAC(),
                    buildLoginBtn(),
                    buildCadastro(),
                  ],
                ),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
