import 'package:change_theme/views/home_page.dart';
import 'package:change_theme/views/login_page.dart';
import 'package:change_theme/main.dart';
import 'package:change_theme/views/users/index_users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    ThemeService themeService = Provider.of<ThemeService>(context);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.purple.withOpacity(0.2),
              Colors.red.withOpacity(0.2),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: ListView(
          // Remove padding
          padding: const EdgeInsets.only(top: 25),
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Oflutter.com'),
              accountEmail: const Text('example@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    //'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                    'https://pbs.twimg.com/media/Dm1neA0X4AEMmnR?format=jpg&name=360x360',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Página Inicial'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Usuários'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const IndexUsers()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Request'),
              onTap: () => {},
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: const Center(
                    child: Text(
                      '8',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                  themeService.isDarkTheme ? Icons.nightlight : Icons.wb_sunny),
              title: Text(
                  'Aparência: ${themeService.isDarkTheme ? "Escuro" : "Claro"}'),
              onTap: () => {
                themeService.isDarkTheme = !themeService.isDarkTheme,
                if (themeService.isDarkTheme)
                  {themeService.switchToDarkTheme()}
                else
                  {themeService.switchToLightTheme()}
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Policies'),
              onTap: () => {},
            ),
            const Divider(),
            ListTile(
              title: const Text('Exit'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () => {showAlertDialogExit(context)},
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialogExit(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Confirmar"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Atenção!"),
      content: const Text("Tem certeza que deseja sair?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // changeTheme() {
  //   setState(() {
  //     isDarkTheme = !isDarkTheme;
  //   });
  // }
}
