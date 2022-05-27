import 'package:flutter/foundation.dart';
import 'package:lucha_fantasy/core/config_reader.dart';
import 'package:lucha_fantasy/core/services/exceptions/empty_fields_exception.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseService {
  static String keyParseServerUrl = 'https://parseapi.back4app.com';

  ParseService() {
    init();
  }

  Future<void> init() async {
    ConfigReader.initialize();

    if(kReleaseMode) {
      await Parse().initialize(ConfigReader.getParseAppProdKey(), keyParseServerUrl, clientKey: ConfigReader.getParseClientProdKey(), debug: true);
    } else {
      await Parse().initialize(
          ConfigReader.getParseAppDevKey(), keyParseServerUrl,
          clientKey: ConfigReader.getParseClientDevKey(), debug: true);
    }
  }

  Future<ParseUser?> getParseUser() async {
    final ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return null;
    }

    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse = await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return null;
    } else {
      return currentUser;
    }
  }

  Future<bool> register({required String username, required String email, required String password}) async {
    if(username != "" && password != "" && email != "") {
      final user = ParseUser.createUser(username.trim(), password, email.trim());

      var response = await user.signUp();

      return response.success;
    } else {
      throw EmptyFieldsException();
    }
  }

  Future<bool> signIn({required String username, required String password}) async {
    if(username != "" && password != "") {
      final user = ParseUser(username.trim(), password, null);

      var response = await user.login();

      return response.success;
    } else {
      throw EmptyFieldsException();
    }
  }

  Future<bool> logOut() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    return response.success;
  }

  Future<void> forgotPassword({required String email}) async {
    final ParseUser user = ParseUser(null, null, email.trim());
    await user.requestPasswordReset();
  }
}
