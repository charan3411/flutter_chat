import 'dart:convert';

import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FCMServiceAccount {
  static const _SCOPES = [
    //'https://www.googleapis.com/auth/cloud-platform.read-only',
    'https://www.googleapis.com/auth/firebase.messaging',
  ];

  Future<String> getAccessToken() async {
    String accessToken = "";
    ServiceAccountCredentials _credentials =
        ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "flutter-chat-34494",
      "private_key_id": "54e2000b68c9b30f20fe97ec61acd5f38338cca0",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDcx5QmjfHbYlnw\nSDYcELVA3uOe8vV72SDyW50SiJ/KWVbbQqE7bH00DF0+/iUHxnHXf1RRF8q/u3zu\npb4Blminy3tiAmPnu4oMg4hH1+Q2Yh1BnXhEEEO/SM35iTzBX9OxBbZFlw8Gg3D/\nI6KylpPu9qU6eQmu403yh+EG4H8BjXcWiegXMXSqbec8MHADLYTcnNCfjzG0Y4R6\n21Tupf06isF+Oh5K9hbqoef6JCdAuJZyMRbV5J1TqGqnBI/bzWSbS0g6SEQAYigs\ngf3I6CpHbNF0FLlakTADsQyuB+/mod8HViNUlLMvD/51Muv1bJrojFbm+wf6RZuN\nMndZ1zgzAgMBAAECggEADR7upDnvA+Q88cWWMvsf4n/nPtTel6J9ou755JY/tNVe\nuZTPTd+dM0DW29MGcrIC+v/ODCxh+BzAMyigzv8C2jytaP45ChZrAQ0Mxi7uQ6Mi\nF6UFoY875NGCrY/6jzLO5b2FVG5tTgGgGgb3+NgaaOsPQmyGEaGK9N0ewlCzi5fM\niZjN5a/ArQI/Hd/hQlOW4OTEqHblcUugBuoVbGBvczkh/OEVj74CKRGc1jeCH2iB\ncTupE/3ZjJjC5BVAE/Hvk3Qyx2UOuFKCHrdjjFGN/wObh3f1H/4HxAk4B9NySnYX\n/abqMQ8uD4LLqBwtuDVmATOmmsjeEBDBAbdmu0MolQKBgQD9VME6kE4leuSxPD4U\n3bMf+NBXMuGHpTlTotxCggkWcfHwr0zsLEG7KJJyVRJDFGW/WlAtZPi60HgDRN6U\nuBs2DlAkdQqmNcLqBGu8ATPgdoSkTTaEYFjIzBaDxKy3pRFOQ/XCALG5Eg0Ak3nD\nUSwnj+O4DRwCVN3WCSucnVXNhwKBgQDfGwf5cYcDos5nRuaBV7+GzoEPEnaGR5O0\n/5nqh6iJKlcS3UAjONZ6S2zVIEbE5ytQiDvnJww7N063XOF+IjdbRmSVzXerLNDW\npFhn5lOohpVjlKVQKMdKQnXz5yq6BTkS1XrVxxVkvp/oE8DQ+ouFG7Uh7ZdpDaa2\nYNisREvK9QKBgQCPRApPG2MGcTy6Ou6FEGgH0cfJOJ4w/zCvavATsMSA7Am+avUe\nr1yxAp3niNLeGr/7+pBTS8IarGDiwGT8SC4jYO7T31kZbFgBzmQ7G5cB/yS+YmhN\nbstnK3wkIurmpLRnxalLgOcBWgL+a2i2G8bTzN0krk1DyEj4jZEbbiMjKwKBgQCM\nYOG/niMpsoLUkNPwhlnIZJ7n8OIK03ao6DrcSsdMpwtqnzP/9X9eK58q6sgclKe4\nYD/wzazwhXhN/28Sgkz6bWxUpZeqaORuabIGjfINk8Dji2AI89+RZgf5k3Za3XZv\n10sWv9FCNn8+807bLwoikrCBzJD8VM6U6pLqsX5PEQKBgQDXCjbJNSMek6nZ61Zm\nBsFkJkhwk0bhO/Ucas3Wi4I/r1PXEqqspkS1Bh3zbqrcrLQA4r6tTZDfxkBDS47R\nGQivh8KaKLkaDvvMa5lQz/9cYGU84L0C2s3/FitftllqRFKFHGmPJCojy0LnnQhM\nufczNi3Odyacs1zHxwoA/Q9tEw==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-6f9sj@flutter-chat-34494.iam.gserviceaccount.com",
      "client_id": "110818511823426379023",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-6f9sj%40flutter-chat-34494.iam.gserviceaccount.com"
    });
    final credentials = _credentials;
    final accessCredentials = await obtainAccessCredentialsViaServiceAccount(
      credentials,
      _SCOPES,
      http.Client(),
    );
    accessToken = accessCredentials.accessToken.data;

    return accessToken;
  }

  Future<void> sendNotification(String fcmToken, String title, String body,
      {String? imageUrl}) async {
    await getAccessToken().then((accessToken) async {
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/flutter-chat-34494/messages:send'));
      request.body = json.encode({
        "message": {
          "token": fcmToken,
          "notification": {"title": title, "body": body}
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
      } else {}
    });
  }
}
