import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String _apiKey = '304B6245-FFBA-46F7-A26D-D7FB43E9B23D';

  List<DropdownMenuItem<String>> getCurrencyDowndownList() {
    return currenciesList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  List<Text> getCurrencyTextWidgets() {
    List<Text> list = [];
    for (var currency in currenciesList) {
      list.add(Text(currency));
    }
    return list;
  }

  List<String> getCurrencyList() {
    return currenciesList;
  }

  List<String> getCryptoList() {
    return cryptoList;
  }

  Future<dynamic> getExchangeRate(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String url = 'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency/?apikey=$_apiKey';

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        String stringData = response.body;
        var data = jsonDecode(stringData);

        jsonDecode(data);
        double price = data['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(2);
      } else {
        print('response status code: ${response.statusCode}');
        throw ('Erreur with the get request');
      }
    }

    return cryptoPrices;
  }
}
