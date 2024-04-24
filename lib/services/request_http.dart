import 'dart:convert';
import 'package:http/http.dart' as http;

getMoedas() async {
  var url = Uri.parse('https://economia.awesomeapi.com.br/all');
  var response = await http.get(url);
  return (jsonDecode(response.body));
}

getFavs(moedas) async {
  String parametros = moedas.join(',');
  var url = Uri.parse('http://economia.awesomeapi.com.br/json/last/${parametros}');
  var response = await http.get(url);
  return (jsonDecode(response.body));
}