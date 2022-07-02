import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/credits/data/model/credits_model.dart';

abstract class CreditsRepo {

  Future<List<CreditsModel>> getAllCreditAds();
  Future<CreditsModel> getCreditAd(String id);
  Future<User?> buyCredits(String creditsId, String userId);

}