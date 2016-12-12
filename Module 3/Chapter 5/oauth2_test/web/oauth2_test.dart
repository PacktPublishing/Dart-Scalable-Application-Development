import 'dart:html';
import "package:google_oauth2_client/google_oauth2_browser.dart";
import "package:google_plus_v1_api/plus_v1_api_browser.dart" as plusclient;

final auth = new GoogleOAuth2("211031121179-60c2nbjeju3mbpltsv89cd4iss721tqf.apps.googleusercontent.com", // Client id
["openid", "email", plusclient.Plus.PLUS_ME_SCOPE], tokenLoaded: oauthReady);

void main() {
  var logIn = new ButtonElement()
      ..text = "Log in with Google"
      ..onClick.listen((_) {
        auth.login();
      });

  var logOut = new ButtonElement()
      ..text = "Log out"
      ..onClick.listen((_) {
        auth.logout();
      });

  document.body.children.add(logIn);
  document.body.children.add(logOut);
}

void oauthReady(Token token) {
  print(token);
  // get the users full name
  var plus = new plusclient.Plus(auth);
  // set the API key
  plus.key = "Axxxxxxxxxxxxxxxxxxx-x-xxxxxxxxx-x";
  plus.oauth_token = auth.token.data;
  plus.people.get("me").then((person) {
    // log the users full name to the console
    print("Hello ${person.name.givenName} ${person.name.familyName}");
  });
}
