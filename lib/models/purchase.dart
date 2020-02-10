import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel {
  static const ID = 'id';
  static const PRODUCT_NAME = 'productName';
  static const AMOUNT = 'amount';
  static const CUSTOMER_ID = 'customerId';
  static const DATE = 'date';
  static const CARD_ID = 'card_id';

  String _id;
  String _productName;
  int _amount;
  String _customerId;
  String _date;
  String _cardId;

  // getters
  String get id => _id;
  String get productName => _productName;
  int get amount => _amount;
  String get customerId => _customerId;
  String get date => _date;
  String get cardId => _cardId;

  PurchaseModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _productName = snapshot.data[PRODUCT_NAME];
    _amount = snapshot.data[AMOUNT];
    _customerId = snapshot.data[CUSTOMER_ID];
    _date = snapshot.data[DATE];
    _cardId = snapshot.data[CARD_ID];
  }

  PurchaseModel.fromMap(Map data) {
    _id = data[ID];
    _productName = data[PRODUCT_NAME];
    _amount = data[AMOUNT];
    _customerId = data[CUSTOMER_ID];
    _date = data[DATE];
    _cardId = data[CARD_ID];
  }

  Map<String, dynamic> toMap() {
    return {
      ID: _id,
      PRODUCT_NAME: _productName,
      CUSTOMER_ID: _customerId,
      DATE: _date,
      CARD_ID: _cardId,
      AMOUNT: _amount
    };
  }
}
