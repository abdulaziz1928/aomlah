import 'package:aomlah/core/app/utils/constants.dart';
import 'package:aomlah/core/models/coin.dart';
import 'package:flutter/material.dart';

class BaseCoinInfo extends StatelessWidget {
  final Coin coin;
  const BaseCoinInfo({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Container(width: 5),
            Text(
              coin.price,
              style: Constants.mediumText,
            ),
            Text(
              coin.change24hr + "%",
              style: TextStyle(
                color: coin.change24hr.startsWith("+")
                    ? Constants.primaryColor
                    : Colors.red,
              ),
            ),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              coin.fullName,
              style: Constants.mediumText.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(coin.name),
          ],
        ),
        Container(width: 5),
        Image.network(
          coin.getFullLogoUrl(),
          height: 50,
          width: 50,
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String field;
  final String fieldValue;
  const InfoRow({
    Key? key,
    required this.field,
    required this.fieldValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff0F1E2C),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xff3D4955),
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            field,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(fieldValue),
        ],
      ),
    );
  }
}
