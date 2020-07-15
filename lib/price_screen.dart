import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/widgets/crypto_card.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'AUD';
  Map<String, dynamic> cryptoPrices;

  bool isWaiting = false;

  void fetchData() async {
    isWaiting = true;

    try {
      var data = await coinData.getExchangeRate(selectedCurrency);
      isWaiting = false;
      setState(() {
        cryptoPrices = data;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget getCupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.amberAccent,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = coinData.getCurrencyList()[selectedIndex];
      },
      itemExtent: 40,
      children: coinData.getCurrencyTextWidgets(),
    );
  }

  Widget getDropdownMenu() {
    return DropdownButton<String>(
      value: selectedCurrency,
      dropdownColor: Colors.amberAccent,
      iconEnabledColor: Color(0xFF844685),
      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      items: coinData.getCurrencyDowndownList(),
      onChanged: (String newValue) {
        selectedCurrency = newValue;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: CryptoCard(
                    selectedCurrency: selectedCurrency,
                    cryptoCurrency: coinData.getCryptoList()[index],
                    exchangeRate: isWaiting ? '?' : cryptoPrices[coinData.getCryptoList()[index]],
                  ),
                );
              },
              itemCount: coinData.getCryptoList().length,
            ),
          ),
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
                SizedBox(width: 5),
                Container(
                  width: 60,
                  child: Platform.isIOS ? getCupertinoPicker() : getDropdownMenu(),
                ),
                SizedBox(width: 10),
                FlatButton(
                  onPressed: fetchData,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF844685),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(
                      'Get Rates',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
