import 'package:lucha_fantasy/core/services/parse_service.dart';
import 'package:lucha_fantasy/features/credits/data/model/credits_model.dart';
import 'package:lucha_fantasy/features/credits/data/repository/credits_repo.dart';

class CreditsRepoImpl implements CreditsRepo {

  final ParseService _parseService;

  CreditsRepoImpl(this._parseService);

  @override
  Future<bool> buyCredits(String id) {
    // TODO: implement buyCredits
    throw UnimplementedError();
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