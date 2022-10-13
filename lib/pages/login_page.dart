import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cadastro_page.dart';
import 'recuperar_senha_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _showPassword = false;

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
          child: const TextField(
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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecuperarSenhaPage(
                  name: 'Recuperar Senha',
                )
            ),
          );
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

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () => Navigator.of(context).pushReplacementNamed(
          '/home_page',
        ),
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xff3d85c6),
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
                    buildRememberAC(),
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
