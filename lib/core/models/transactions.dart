import 'package:aomlah/core/enums/crypto_types.dart';

class Transaction {
  final String from;
  final String to;
  final int total;
  final int fees;
  final DateTime confirmedDate;

  Transaction({
    required this.from,
    required this.to,
    required this.total,
    required this.fees,
    required this.confirmedDate,
  });
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      from: (((json['inputs'] as List)[0]['addresses'] as List))[0],
      to: (((json['outputs'] as List)[0]['addresses'] as List))[0],
      total: ((json['outputs'] as List)[0])['value'],
      fees: json['fees'],
      confirmedDate:
          DateTime.parse(json['confirmed'] ?? DateTime(0).toString()),
    );
  }
  String satsToBTC(int sats) {
    double n = (sats / 100000000.0);
    return '$n';
  }

  String weiToETH(int wei) {
    double n = (wei / 1000000000000000000.0);
    return '$n';
  }

  convert(int total, CryptoTypes types) {
    if (types == CryptoTypes.btc) {
      double n = (total / 100000000.0);
      return '$n';
    } else if (types == CryptoTypes.eth) {
      double n = (total / 1000000000000000000.0);
      return '$n';
    }
  }
}
