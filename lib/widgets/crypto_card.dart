import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String selectedCurrency;
  final String cryptoCurrency;
  final String exchangeRate;

  CryptoCard({this.cryptoCurrency, this.selectedCurrency, this.exchangeRate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF844685),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          //TODO: Make Dynamic
          '1 $cryptoCurrency = $exchangeRate $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
