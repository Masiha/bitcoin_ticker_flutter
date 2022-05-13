import 'package:bitcoin_ticker_flutter/crypto_card.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

// ignore: use_key_in_widget_constructors
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: [
          for (String currency in currenciesList)
            DropdownMenuItem(
              child: Text(currency),
              value: currency,
            )
        ],
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            getData();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: [
        for (String currency in currenciesList) Text(currency),
      ],
    );
  }

  // Value had to be updated into a Map to store the values of all three cryptocurrencies.
  Map<String, String> coinValues = {};
  // Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;

  // A method here called getData() to get the coin data from coin_data.dart
  void getData() async {
    isWaiting = true;
    try {
      // Update this method to receive a Map containing the crypto:price key value pairs.
      var data = await CoinData().getCoinData(selectedCurrency);
      // As soon the above line of code completes, we now have the data and no longer need to wait. So we can set isWaiting to false.
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      //print(e);
      throw 'Problem in fetching data. / check the API key.';
    }
  }

  @override
  void initState() {
    super.initState();
    // Call getData() when the screen loads up.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // A loops through the cryptoList and generates a CryptoCard for each.
            for (String crypto in cryptoList)
              CryptoCard(
                  cryptoCurrency: crypto,
                  // Use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
                  value: isWaiting ? '?' : coinValues[crypto]!,
                  selectedCurrency: selectedCurrency),
          ]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
