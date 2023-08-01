import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeOrdersScreen extends StatefulWidget {
  final pedidos;
  SeeOrdersScreen({super.key, this.pedidos});

  @override
  State<SeeOrdersScreen> createState() => _SeeOrdersScreenState();
}

class _SeeOrdersScreenState extends State<SeeOrdersScreen> {
  bool _isDarkMode = false;
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
                Icons.shopping_cart,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
              Text('Pedidos realizados',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black)),
            ],
          )),
      body: Container(
        color: _isDarkMode ? Colors.black : Colors.white,
      ),
    );
  }
}
