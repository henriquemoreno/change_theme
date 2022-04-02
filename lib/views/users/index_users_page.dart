import 'package:change_theme/database/sql_helper.dart';
import 'package:change_theme/models/login_model.dart';
import 'package:change_theme/views/users/create_users_page.dart';
import 'package:change_theme/views/users/edit_users_page.dart';
import 'package:change_theme/widgets/appbar.dart';
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
      appBar: const CustomAppBar(title: 'Usuários'),
      drawer: const NavBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: loginList.length + 1,
              itemBuilder: (ctx, index) {
                return index == loginList.length
                    ? const SizedBox(height: 60)
                    : Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: getRadomColor(index), width: 2)),
                        color: Colors.white,
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                            title: Text(
                                "Nome: " + loginList.elementAt(index).name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email: " +
                                    loginList.elementAt(index).email),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 140,
                              child: Row(
                                children: [
                                  // IconButton(
                                  //   icon: const Icon(Icons.edit),
                                  //   onPressed: () => {},
                                  //   //_showForm(_journals[index]['id']),
                                  //   color: Colors.amber[800],
                                  // ),
                                  // IconButton(
                                  //   icon: const Icon(Icons.delete),
                                  //   onPressed: () =>
                                  //       {}, //showAlertDialog(context, index),
                                  //   color: Colors.red,
                                  // ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditUsers(
                                                  id: loginList
                                                      .elementAt(index)
                                                      .id!)));
                                    },
                                    child: const Icon(Icons.edit,
                                        color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      primary: Colors
                                          .yellow[900], // <-- Button color
                                      onPrimary: Colors.red, // <-- Splash color
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Icon(Icons.delete,
                                        color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      primary: Colors
                                          .redAccent[700], // <-- Button color
                                      onPrimary: Colors.red, // <-- Splash color
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );

                //OUTRO JEITO DE FAZER "CARDS"

                // return Container(
                //     margin: const EdgeInsets.all(8.0),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10.0),
                //       border: Border.all(
                //         width: 2.0,
                //         color: getRadomColor(),
                //       ),
                //       boxShadow: const [
                //         BoxShadow(
                //           color: Colors.black26,
                //           offset: Offset(0, 2),
                //           blurRadius: 6.0,
                //         ),
                //       ],
                //     ),
                //     child: ListTile(
                //         title: Text("Nome: " + loginList.elementAt(index).name),
                //         subtitle: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text("Email: " + loginList.elementAt(index).email),
                //           ],
                //         ),
                //         trailing: SizedBox(
                //           width: 100,
                //           child: Row(
                //             children: [
                //               IconButton(
                //                 icon: const Icon(Icons.edit),
                //                 onPressed: () => {},
                //                 //_showForm(_journals[index]['id']),
                //                 color: Colors.amber[800],
                //               ),
                //               IconButton(
                //                 icon: const Icon(Icons.delete),
                //                 onPressed: () =>
                //                     {}, //showAlertDialog(context, index),
                //                 color: Colors.red,
                //               ),
                //             ],
                //           ),
                //         )));
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Colors.purple, Colors.red])),
        ),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateUsers()))
        },
        tooltip: 'Increment',
      ),
    );
  }

  Color getRadomColor(int index) {
    if (index % 2 == 0) {
      return const Color.fromARGB(255, 125, 4, 224);
    } else {
      return const Color.fromARGB(255, 235, 7, 178);
    }
    // var colors = [];
    // colors.add(Colors.red[400]);
    // colors.add(Colors.green[400]);
    // colors.add(Colors.blue[400]);
    // colors.add(Colors.purple[400]);
    // colors.add(Colors.orange[400]);
    // return Colors.primaries[Random().nextInt(colors.length)];
  }
}
