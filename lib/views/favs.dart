import 'package:flutter/material.dart';
import '../services/request_http.dart';

class Fav extends StatefulWidget {
  List favoritos;
  Fav({super.key, required this.favoritos});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 168, 168),
      appBar: AppBar(
        title: Text("Moedas Favoritas"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future:
            widget.favoritos.length > 0 ? getFavs(widget.favoritos) : null,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<String> indexMoedas =
                snapshot.data != null ? snapshot.data.keys.toList() : [];
            return ListView.builder(
              itemCount: indexMoedas.length,
              itemBuilder: (context, index) {
                var moeda = snapshot.data[indexMoedas[index]];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${moeda['name']}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${moeda['code']}-${moeda['codein']}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Mínimo do dia: R\$ ${moeda['low']}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Máximo do dia: R\$ ${moeda['high']}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Valor Atual: R\$ ${moeda['bid']}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ));
}
}
