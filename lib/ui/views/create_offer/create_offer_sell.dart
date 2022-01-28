import 'package:flutter/material.dart';
import 'package:aomlah/core/app/utils/constants.dart';

import '../../shared/custom_button.dart';

class CreateOfferSell extends StatefulWidget {
  const CreateOfferSell({Key? key}) : super(key: key);

  @override
  State<CreateOfferSell> createState() => _CreateOfferSellState();
}

class _CreateOfferSellState extends State<CreateOfferSell> {
  final cryptoList = ['BTC', 'ETH', 'USDT'];
  String? cListVal;
  final currencyList = ['ر.س', 'USD'];
  String? currListVal;
  int margin = 100;

  TextEditingController _cryptoAmountController = TextEditingController();
  TextEditingController _minTradeController = TextEditingController();
  TextEditingController _termsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    cListVal ??= cryptoList.first;
    currListVal ??= currencyList.first;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          ///Crypto type
          Row(
            children: const <Widget>[
              SizedBox(
                width: 20,
              ),
              Expanded(child: Text('عملة')),
              Expanded(child: Text('مقابل العملة التقليدية'))
            ],
          ),
          ///Currency type
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Constants.black3dp,
                    ),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                    child:
                    DropdownButtonHideUnderline(child: menuCryptoButton())),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Constants.black3dp,
                    ),
                    margin: EdgeInsets.fromLTRB(20, 0, 10, 10),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                    child:
                    DropdownButtonHideUnderline(child: menuCurrencyButton())),
              ),
            ],
          ),

          ///Price Margin
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: const <Widget>[
              SizedBox(width: 20),
              Text(
                'نسبة هامش السعر ',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          ///Price Margin value
          Card(
            color: Constants.black3dp,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: ListTile(
              // contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2),
              leading: TextButton(
                  onPressed: () {
                    if (margin < 200) {
                      setState(() {
                        margin++;
                      });
                    };
                  },
                  child: Text('+')
              ),

              title: Center(child: Text(margin.toString() + "%")),
              trailing: TextButton(
                  onPressed: () {
                    if (margin > 50) {
                      setState(() {
                        margin--;
                      });
                    };
                  },
                  child: Text('-')
              ),
            ),
          ),

          ///Amount of Crypto
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              SizedBox(width: 20),
              Text(
                'الكمية الاجمالية',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          ///Amount of Crypto text form
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Constants.black3dp,
            ),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(

              children: [
                Expanded(child:
                Text(

                  cListVal as String
                  , textAlign: TextAlign.center,),
                  flex: 1,
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: _cryptoAmountController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        hintText: 'ادخل الكمية الاجمالية',
                        border: InputBorder.none),
                    keyboardType: TextInputType.number,
                  ),),
              ],
            ),
          ),

          ///min trade amount
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              SizedBox(width: 20),
              Text(
                'الحد الادنى للتبادل',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          ///min tradeamount text form
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Constants.black3dp,
            ),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              children: [
                Expanded(child:
                Text(
                  currListVal as String
                  , textAlign: TextAlign.center,),
                  flex: 1,
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: _minTradeController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        hintText: 'ادخل الحد الادنى', border: InputBorder.none),
                    keyboardType: TextInputType.number,
                  ),),
              ],
            ),
          ),
          
          ///Bank account selection
          Container(
            // color: Constants.black3dp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              color: Constants.black3dp,
            ),
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: [
                Row(
                  
                  children:  [
                    SizedBox(width: 15,),
                    Expanded(child: Text('الحسابات البنكية')),
                    Expanded(child: Container(
                      margin: EdgeInsets.fromLTRB(10,5,0,0),
                      child: CustomButton(

                        onPressed: (){
                        },
                         text: 'اضف' ,
                        
                      ),
                    )
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Text('*اختر ثلاث حسابات كحد اقصى',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    )
                  ],
                ),
                Row(
                  children: const[
                    SizedBox(width: 15,),
                    Expanded(child: Text('b1')),
                    Expanded(child: Text('b2')),
                    Expanded(child: Text('b3')),

                  ],
                ),
              ],
            ),
            
          ),
          
          ///Trade Terms and Conditions
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              SizedBox(width: 20),
              Text(
                'الشروط والاحكام',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          ///Trade Terms and Conditions text form
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Constants.black3dp,
            ),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children:  <Widget>[
                SizedBox(width: 20,),
                Expanded(
                  child: TextFormField(
                    controller: _termsController,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: 'ادخل الشروط والاحكام',
                        border: InputBorder.none),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),

          ///Submit Form
          Container(
            color: Constants.primaryColor,
            child: Row(

              children: [
                Expanded(
                  child: TextButton(

                    onPressed: (){
                      print('Crypro type: '+ cListVal.toString());
                      print('Currency Type: '+ currListVal.toString());
                      print('price margin: '+ margin.toString());
                      print('Total Crypto: '+ _cryptoAmountController.text);
                      print('Min Trade: '+ _minTradeController.text);
                      print('Terms: '+ _termsController.text);

                    },
                    child: Text('submit',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          )




        ],
      ),
    );
  }

  DropdownButton menuCryptoButton() =>
      DropdownButton(
        items: cryptoList.map(buildCryptoItems).toList(),
        onChanged: (value) => setState(() => this.cListVal = value as String?),
        value: cListVal,
        // isExpanded: true,
      );

  DropdownButton menuCurrencyButton() =>
      DropdownButton(
        items: currencyList.map(buildCryptoItems).toList(),
        onChanged: (value) =>
            setState(() => this.currListVal = value as String?),
        value: currListVal,
      );

  DropdownMenuItem<String> buildCryptoItems(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );


}