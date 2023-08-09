import 'package:acfashion_store/ui/auth/perfil.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:acfashion_store/ui/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeUsersScreen extends StatefulWidget {
  final usuarios;
  SeeUsersScreen({super.key, this.usuarios});

  @override
  State<SeeUsersScreen> createState() => _SeeUsersScreenState();
}

class _SeeUsersScreenState extends State<SeeUsersScreen> {
  bool _isDarkMode = false;
  List<UsersModel> usuarios = [];

  @override
  void initState() {
    super.initState();
    usuarios = widget.usuarios;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: _isDarkMode ? Colors.grey.shade900 : Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new,
                  color: _isDarkMode ? Colors.white : Colors.black)),
          title: Row(
            children: [
              Icon(
                Icons.person,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
              Text('Lista de usuarios de mi app',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black)),
            ],
          )),
      body: Container(
        color: _isDarkMode ? Colors.black : Colors.white,
        child: Expanded(
          // Use Expanded here to make the ListView take all available space
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: usuarios.length,
              itemBuilder: (BuildContext context, int index) {
                Color colorFondo =
                    _isDarkMode ? Colors.grey.shade900 : Colors.white;
                return Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: colorFondo,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Perfil(
                              perfil: usuarios[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Usuario ${usuarios.indexOf(usuarios[index]) + 1}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  " - Tel: ${usuarios[index].celular}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                usuarios[index].foto != ''
                                    ? CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                          usuarios[index].foto,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                          "assets/images/user.png",
                                        ),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  usuarios[index].nombre,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
