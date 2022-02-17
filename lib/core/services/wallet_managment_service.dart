import 'dart:convert';

import 'package:aomlah/core/app/api_keys.dart';
import 'package:aomlah/core/app/logger.dart';
import 'package:aomlah/core/models/real_time_wallet.dart';
import 'package:aomlah/core/models/unconfirmed_transaction.dart';
import 'package:aomlah/core/models/wallet.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';

enum HttpVreb {
  post,
  get,
}

class WalletManagmentService {
  final _logger = getLogger("WalletManagmentService");

  static const token = APIKeys.blockcypherKey;
  static const baseUrl = "https://api.blockcypher.com/v1/bcy/test";

  Future<dynamic> sendRequest({
    required String path,
    required HttpVreb req,
    String? body,
    bool includeToken = true,
  }) async {
    Uri url =
        Uri.parse("$baseUrl/$path" + (includeToken ? "?token=$token" : ""));
    late Future request;
    switch (req) {
      case HttpVreb.post:
        request = http.post(url, body: body);
        break;
      case HttpVreb.get:
        request = http.get(url);
        break;
    }
    final response = await request;
    final decodedRes = jsonDecode(response.body);
    return decodedRes;
  }

  Future<Wallet> createWallet(String uuid) async {
    _logger.i("createWallet | args: uuid = $uuid");

    final generatedKeys = await sendRequest(path: "addrs", req: HttpVreb.post);
    Wallet wallet = Wallet.fromBlockchainJson(generatedKeys);
    final walletData = {
      "name": uuid,
      "addresses": [wallet.address]
    };

    await sendRequest(
        path: "wallets", body: jsonEncode(walletData), req: HttpVreb.post);

    wallet.profileId = uuid;
    return wallet;
  }

  // Future<dynamic> confirmTransaction(String from, String to, int value) async {
  //   _logger.i("transaction | to=$to");
  //   Uri url = Uri.parse("$baseUrl/txs/new");
  //   final data = jsonEncode({
  //     "inputs": [
  //       {
  //         "addresses": [from]
  //       }
  //     ],
  //     "outputs": [
  //       {
  //         "addresses": [to],
  //         "value": value
  //       }
  //     ]
  //   });
  //   return http.post(url, body: data);
  // }

  Future<void> fundMe(String address) async {
    _logger.i("fundMe | args: address=$address");

    Uri url = Uri.parse("$baseUrl/faucet?token=$token");
    final data = jsonEncode({"address": address, "amount": 500000});
    await http.post(url, body: data);
  }

  Future<UnconfirmedTransaction> sendTransaction(
      String from, String to, amount) async {
    _logger.i("transaction | to=$to");
    Uri url = Uri.parse("$baseUrl/txs/new");
    final data = {
      "inputs": [
        {
          "addresses": [from]
        }
      ],
      "outputs": [
        {
          "addresses": [to],
          "value": amount
        }
      ]
    };
    var m = await http.post(url, body: jsonEncode(data));
    UnconfirmedTransaction trs =
        UnconfirmedTransaction.fromJson(jsonDecode(m.body));
    print(jsonDecode(m.body));
    print(m.body);
    // print(jsonDecode(m.body)['tx']['total']);
    return trs;
  }

  Future<RealTimeWallet> getWalletInfo(String address) async {
    _logger.i("getWalletInfo | args: address=$address");

    final response = await sendRequest(
      path: "addrs/$address/full",
      includeToken: false,
      req: HttpVreb.get,
    );
    final wallet = RealTimeWallet.fromJson(response);

    return wallet;
  }

  Future<void> sendSignedTransaction(Map<String, dynamic> signedJson) async {
    var encodedJson = jsonEncode(signedJson);
    Uri url = Uri.parse("$baseUrl/txs/send");

    var m = await http.post(url, body: encodedJson);
    var decoded = jsonDecode(m.body);
    print(decoded['tosign'][0] + '0000000000000033');
    print(m.body);
  }
}
