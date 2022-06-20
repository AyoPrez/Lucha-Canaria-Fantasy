import 'package:lucha_fantasy/features/credits/data/model/credits_model.dart';
import 'package:lucha_fantasy/features/credits/data/repository/credits_repo.dart';
import 'package:lucha_fantasy/features/credits/ui/credits_view.dart';

abstract class CreditsPresenter {

  Future<List<CreditsModel>> getAllCreditAds();
  Future<CreditsModel> getCreditAd(String id);
  Future<bool> buyCredits(String id);
  Future<String> getUserBalance(String userId);

  void setCreditsView(CreditsView view);
}

class CreditsPresenterImpl extends CreditsPresenter {

  CreditsRepo creditsRepo;
  CreditsView? _creditsView;

  CreditsPresenterImpl(this.creditsRepo);

  @override
  Future<bool> buyCredits(String id) {
    // TODO: implement buyCredits
    throw UnimplementedError();
  }

  @override
  void setCreditsView(CreditsView view) {
    _creditsView = view;
  }

  @override
  Future<String> getUserBalance(String userId) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<List<CreditsModel>> getAllCreditAds() {
    return creditsRepo.getAllCreditAds();
  }

  @override
  Future<CreditsModel> getCreditAd(String id) {
    // TODO: implement getCreditAd
    throw UnimplementedError();
  }

}