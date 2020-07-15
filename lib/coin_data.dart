import 'package:flutter/material.dart';

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
}
