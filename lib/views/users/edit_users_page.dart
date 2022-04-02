import 'package:change_theme/database/login_sql_helper.dart';
import 'package:change_theme/models/login_model.dart';
import 'package:change_theme/views/users/index_users_page.dart';
import 'package:change_theme/widgets/appbar.dart';
import 'package:flutter/material.dart';

class EditUsers extends StatefulWidget {
  const EditUsers({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<EditUsers> createState() => _EditUsersState();
}

class _EditUsersState extends State<EditUsers> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  late Login login;
  bool isLoading = true;

  void _loadLogin() async {
    final data = await LoginSqlHelper.getUsersById(widget.id);
    setState(() {
      login = data;
      email = login.email;
      name = login.name;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Editar Usuários"),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            initialValue: login.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nome obrigatório';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              name = value;
                            },
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                labelText: 'Nome',
                                hintText: 'Fulano da Silva'),
                          ),
                        ),
                        Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 0),
                          child: TextFormField(
                            initialValue: login.email,
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
                        const Divider(height: 30),
                        Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var entrada = Login(
                                    id: widget.id,
                                    name: name,
                                    email: email,
                                    password: login.password);
                                await LoginSqlHelper.updateLogin(entrada);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const IndexUsers()));
                              }
                            },
                            child: const Text(
                              'Editar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    )),
              ));
  }
}
