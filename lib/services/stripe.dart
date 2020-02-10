import 'dart:io';

import 'package:dio/dio.dart';

class StripeServices {
  static const PUBLISHABLE_KEY = "pk_test_yjoqNiwXmQItAsAEiqZFpChC00KxJ7Jfay";
  static const SECRET_KEY = "sk_test_sLfy1Vv4gJCALJExh6Gd0R3S00ZNssmp3u";

  Future<void> createStripeCustomer(String email) async {
    Map<String, String> data = {
      'email': email,
    };

    Dio()
        .post("https://api.stripe.com/v1/customers",
            data: data,
            options: Options(contentType: "application/x-www-form-urlencoded"))
        .then((response) {
      print(response.data.toString());
    });
  }
}
