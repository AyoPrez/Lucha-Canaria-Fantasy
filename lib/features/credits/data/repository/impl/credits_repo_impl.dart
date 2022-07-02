import 'package:lucha_fantasy/core/services/parse_service.dart';
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/credits/data/model/credits_model.dart';
import 'package:lucha_fantasy/features/credits/data/repository/credits_repo.dart';

class CreditsRepoImpl implements CreditsRepo {

  final ParseService _parseService;

  CreditsRepoImpl(this._parseService);

  @override
  Future<User?> buyCredits(String creditId, String userId) {

    try {
      return _parseService.updateUserCredits(creditId, userId);
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<List<CreditsModel>> getAllCreditAds() async {
    final List<CreditsModel> credits = await _parseService.getAllCreditAds();

    credits.sort((a, b) => a.price.compareTo(b.price));

    return credits;
  }

  @override
  Future<CreditsModel> getCreditAd(String id) {
    // TODO: implement getCreditAd
    throw UnimplementedError();
  }
  
}