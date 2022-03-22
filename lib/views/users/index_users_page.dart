import 'package:change_theme/database/sql_helper.dart';
import 'package:change_theme/models/login_model.dart';
import 'package:change_theme/widgets/navbar.dart';
import 'package:flutter/material.dart';

class IndexUsers extends StatefulWidget {
  const IndexUsers({Key? key}) : super(key: key);

  @override
  State<IndexUsers> createState() => _IndexUsersState();
}

class _IndexUsersState extends State<IndexUsers> {
  List<Login> loginList = [];
  bool isLoading = true;

  void _loadData() async {
    final data = await SQLHelper.getUsers();
    setState(() {
      loginList = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários"),
      ),
      //drawer: const NavBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: loginList.length,
              itemBuilder: (ctx, index) => Card(
                color: Colors.green[50],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text("Nome: " + loginList.elementAt(index).name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: " + loginList.elementAt(index).email),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => {},
                            //_showForm(_journals[index]['id']),
                            color: Colors.amber[800],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                {}, //showAlertDialog(context, index),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
    );
  }
}
