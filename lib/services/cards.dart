import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mastering_payments/models/cards.dart';

class CardService{
  static const CUSTOMER_ID = 'customerId';

  String collection = "cards";
  Firestore _firestore = Firestore.instance;

  void createCard(Map<String, dynamic> values){
    _firestore.collection(collection).document(values["id"]).setData(values);
  }

  void updateDetails(Map<String, dynamic> values){
    _firestore.collection(collection).document(values["id"]).updateData(values);
  }

  void deleteCard(Map<String, dynamic> values){
    _firestore.collection(collection).document(values["id"]).delete();
  }

  Future<List<CreditCardModel>> getPurchaseHistory({String custormerId}) async =>
      _firestore
          .collection(collection)
          .where(CUSTOMER_ID, isEqualTo: custormerId)
          .getDocuments()
          .then((res) {
        List<CreditCardModel> listOfCards = [];
        res.documents.map((item) {
          listOfCards.add(CreditCardModel.fromSnapshot(item));
        });
        return listOfCards;
      });
}