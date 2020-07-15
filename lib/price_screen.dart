import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/widgets/crypto_card.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'CAD';

  List<Widget> getCryptoCards() {
    List<Widget> cryptoCards = [];
    for (var crypto in coinData.getCryptoList()) {
      cryptoCards.add(
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: CryptoCard(
            selectedCurrency: selectedCurrency,
            cryptoCurrency: crypto,
            value: 1.54,
          ),
        ),
      );
    }
    return cryptoCards;
  }

  Widget getCupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.amberAccent,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = coinData.getCurrencyList()[selectedIndex];
        });
      },
      itemExtent: 40,
      children: coinData.getCurrencyTextWidgets(),
    );
  }

  Widget getDropdownMenu() {
    return DropdownButton<String>(
      value: selectedCurrency,
      dropdownColor: Colors.amberAccent,
      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      items: coinData.getCurrencyDowndownList(),
      onChanged: (String newValue) {
        setState(() {
          selectedCurrency = newValue;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crypto Price Rates',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: getCryptoCards(),
            ),
          ),
//          Padding(
//            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//            child: CryptoCard(
//              selectedCurrency: selectedCurrency,
//              cryptoCurrency: 'BTC',
//              value: 1.54,
//            ),
//          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.amberAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Choose currency: ',
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 15),
                Container(
                  width: 60,
                  child: Platform.isIOS ? getCupertinoPicker() : getDropdownMenu(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
