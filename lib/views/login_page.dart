import 'package:change_theme/database/login_sql_helper.dart';
import 'package:change_theme/views/home_page.dart';
import 'package:change_theme/models/login_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                      width: 500,
                      height: 350,
                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('assets/images/flutter-logo.png')),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email obrigatório';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'exemplo@exemplo.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Senha obrigatória';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      hintText: 'Senha de acesso'),
                ),
              ),
              TextButton(
                onPressed: () {
                  //FORGOT PASSWORD SCREEN GOES HERE
                },
                child: const Text(
                  'Esqueci a Senha',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              const Text('Novo Usuário? Criar Conta')
            ],
          ),
        ),
      ),
    );
  }

  Future login() async {
    var existe = await LoginSqlHelper.getCountByEmail();

    if (existe == 0) {
      var login = Login(
          name: 'Teste', email: 'teste@teste.com.br', password: '123mudar!');

      await LoginSqlHelper.insertlogin(login);
    }

    if (await LoginSqlHelper.getByEmailPassword(email, password)) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email e senha inválidos!'),
        ),
      );
    }
  }
}
