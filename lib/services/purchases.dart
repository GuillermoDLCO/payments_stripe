import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mastering_payments/models/purchase.dart';

class PurchaseServices {
  static const CUSTOMER_ID = 'customerId';

  String collection = "purchases";
  Firestore _firestore = Firestore.instance;

  void createPurchase(Map<String, dynamic> values) {
    _firestore.collection(collection).document(values["id"]).setData(values);
  }

  Future<List<PurchaseModel>> getPurchaseHistory({String custormerId}) async =>
      _firestore
          .collection(collection)
          .where(CUSTOMER_ID, isEqualTo: custormerId)
          .getDocuments()
          .then((res) {
        List<PurchaseModel> listOfPurchases = [];
        res.documents.map((item) {
          listOfPurchases.add(PurchaseModel.fromSnapshot(item));
        });
        return listOfPurchases;
      });

  // void updateDetails(Map<String, dynamic> values){
  //   _firestore.collection(collection).document(values["id"]).updateData(values);
  // }

  // Future<UserModel> getPurchaseById(String id) =>
  //     _firestore.collection(collection).document(id).get().then((doc){
  //       return PurchaseModel.fromSnapshot(doc);
  //     });
}
