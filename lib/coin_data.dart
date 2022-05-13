import 'package:bitcoin_ticker_flutter/networking.dart';

const String coinAPIURL = "https://rest.coinapi.io/v1/exchangerate";
const String apiKey = "Use your own api key 😜";

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
  Future<Map<String, String>> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    // A for loop here to loop through the cryptoList and request the data for each of them in turn.
    for (String cryptoName in cryptoList) {
      // Update the URL to use the crypto symbol from the cryptoList.
      NetworkHelper networkHelper = NetworkHelper(
          '$coinAPIURL/$cryptoName/$selectedCurrency?apikey=$apiKey');
      String lastPrice = await networkHelper.getData();
      cryptoPrices[cryptoName] = lastPrice;
    }
    // Return a Map of the results instead of a single value.
    return cryptoPrices;
  }
}
