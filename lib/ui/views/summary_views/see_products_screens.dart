import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeProductsScreen extends StatefulWidget {
  final productos;
  SeeProductsScreen({super.key, this.productos});

  @override
  State<SeeProductsScreen> createState() => _SeeProductsScreenState();
}

class _SeeProductsScreenState extends State<SeeProductsScreen> {
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
                Icons.business_center,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
              Text('Productos realizados',
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
