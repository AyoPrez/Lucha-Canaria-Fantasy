import 'package:lucha_fantasy/features/credits/data/model/credits_model.dart';

abstract class CreditsRepo {

  Future<List<CreditsModel>> getAllCreditAds();
  Future<CreditsModel> getCreditAd(String id);
  Future<bool> buyCredits(String id);

}