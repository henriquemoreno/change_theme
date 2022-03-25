import 'package:change_theme/widgets/navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        //actions: [
        // Switch(
        //     value: isDarkTheme,
        //     onChanged: (value) {
        //       setState(() {
        //         isDarkTheme = value;
        //       });
        //     }),
        // IconButton(
        //     onPressed: () {
        //       changeTheme();
        //     },
        //     icon: Icon(
        //       isDarkTheme ? Icons.nightlight : Icons.wb_sunny,
        //       size: 20,
        //       color: Colors.white,
        //     ))
        //],
      ),
      drawer: const NavBar(),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [],
            ),
          ),
        ),
      ),
    );
  }
}
