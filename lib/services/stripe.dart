import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mastering_payments/services/user.dart';

class StripeServices {
  static const PUBLISHABLE_KEY = "pk_test_yjoqNiwXmQItAsAEiqZFpChC00KxJ7Jfay";
  static const SECRET_KEY = "sk_test_sLfy1Vv4gJCALJExh6Gd0R3S00ZNssmp3u";
  static const PAYMENT_METHOD_URL = "https://api.stripe.com/v1/payment_methods";
  static const CUSTOMERS_URL = "https://api.stripe.com/v1/customers";
  static const CHARGE_URL = "https://api.stripe.com/v1/charges";

  Map<String, String> headers = {
    'Authorization': "Bearer $SECRET_KEY",
    "ContentType": "application/x-www-form-urlencoded"
  };

  Future<void> createStripeCustomer({String email, String userId}) async {
    Map<String, String> body = {
      'email': email,
    };

    http.post(CUSTOMERS_URL, body: body, headers: headers).then((response) {
      String stripeId = jsonDecode(response.body)["id"];
      print("The stripe id is: $stripeId");
      UserService userService = UserService();
      userService.updateDetails({
        "id": userId,
        "stripeId": stripeId,
      });
    }).catchError((err) {
      print("======== THERE WAS AN ERROR =====: " + err.toString());
    });

    // Dio()
    //     .post("https://api.stripe.com/v1/customers",
    //         data: data,
    //         options: Options(contentType: "application/x-www-form-urlencoded"))
    //     .then((response) {
    //   print("======== THERE WAS AN ERROR =====: " + response.data.toString());
    // });

    Future addCard(
        {int cardNumber, int month, int year, int cvc, String stripeId}) {
      Map<String, dynamic> body = {
        'card[number]': cardNumber,
        'card[exp_month]': month,
        'card[exp_year]': year,
        'card[cvc]': cvc,
      };
      Dio()
          .post(PAYMENT_METHOD_URL,
              data: body,
              options: Options(
                  contentType: Headers.formUrlEncodedContentType,
                  headers: headers))
          .then((req) {
        String paymentMethod = json.decode(req.data)["id"];
        print("=== The payment method id ===: $paymentMethod");
        http
            .post(
                "https://api.stripe.com/v1/payment_methods/$paymentMethod/attach",
                body: {"customer": stripeId},
                headers: headers)
            .then((response) {
          print("CODE ZERO");
        }).catchError((err) {
          print("ERROR ATTACHING CARD TO CUSTOMER");
          print("ERROR: ${err.toString()}");
        });
      }).catchError((err) {
        print("======== THERE WAS AN ERROR =====: " + err.toString());
      });

      Future<void> charge({String customer, int amount}) async {
        Map<String, dynamic> data = {
          "amount": amount,
          "currency": "usd",
          "source": "tok_amex",
          "customer": customer,
        };

        Dio()
            .post(CHARGE_URL,
                data: data,
                options: Options(
                    contentType: Headers.formUrlEncodedContentType,
                    headers: headers))
            .then((response) {
          print("response: ${response.toString()}");
        }).catchError((err) {
          print("There was an error charging the customer: ${err.toString()}");
        });
      }
    }
  }
}
