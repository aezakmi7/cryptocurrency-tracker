import 'dart:convert';

import 'package:bitcoin_flutter_app/utilities/constants.dart';
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
  Future getCoinData(String selectedCurrency) async {
    //4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //5: Return a Map of the results instead of a single value.
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      //Update the URL to use the crypto symbol from the cryptoList
      String requestURL =
          '$kCoinRateUrl/$crypto/$selectedCurrency?apikey=$kApiKey';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        //Create a new key value pair, with the key being the crypto symbol and the value being the lastPrice of that crypto currency.
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
