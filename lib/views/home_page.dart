import 'package:flutter_application_7/views/favs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/views/favs.dart';
import '../services/request_http.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List favoritos = [];
  TextEditingController filterController = TextEditingController();

  void addFavorite(String code) {

    if (favoritos.contains(code)) {
      setState(() => {favoritos.remove(code)});
    } else {
      setState(() => {favoritos.add(code)});
    }
  }

  void filtrar(String filtro) {
    setState(() => {});
  }

  void isFavorito(String code){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 168, 168),
      appBar: AppBar(
        title: Text("Lista de Moedas"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            color: Colors.yellow,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Fav(
                            favoritos: favoritos,
                          )));
              ;
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: filterController,
              decoration: InputDecoration(
                labelText: 'Filtrar',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: filtrar,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getMoedas(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<String> indexMoedas = snapshot.data.keys.toList();
                  List<String> moedasFiltradas = indexMoedas
                      .where((moeda) => moeda.contains(filterController.text))
                      .toList();
                  return ListView.builder(
                    itemCount: moedasFiltradas.length,
                    itemBuilder: (context, index) {
                      var moeda = snapshot.data[moedasFiltradas[index]];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onLongPress: () => addFavorite(
                              '${moeda['code']}-${moeda['codein']}'),
                          child: Card(
                            elevation: 10,
                            color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        '${moeda['name']}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        '${moeda['code']}-${moeda['codein']}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        'Valor Atual: R\$ ${moeda['bid']}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  favoritos.contains(
                                          '${moeda['code']}-${moeda['codein']}')
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.yellow,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
