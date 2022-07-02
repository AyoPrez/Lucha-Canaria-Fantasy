import 'package:lucha_fantasy/core/services/exceptions/error_during_purchase_credits_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_credits_purchased_exception.dart';
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';
import 'package:lucha_fantasy/features/credits/data/model/credits_model.dart';
import 'package:lucha_fantasy/features/credits/data/repository/credits_repo.dart';
import 'package:lucha_fantasy/features/credits/ui/credits_view.dart';
import 'package:lucha_fantasy/features/main/ui/mainView.dart';

abstract class CreditsPresenter {

  Future<List<CreditsModel>> getAllCreditAds();
  Future<CreditsModel> getCreditAd(String id);
  Future<void> buyCredits(String id, String userId);
  Future<int> getUserBalance(String userId);

  void setCreditsView(CreditsView view);
  void setMainView(MainView view);
}

class CreditsPresenterImpl extends CreditsPresenter {

  CreditsRepo creditsRepo;
  Auth auth;
  CreditsView? _creditsView;
  MainView? _mainView;

  CreditsPresenterImpl(this.creditsRepo, this.auth);

  @override
  Future<void> buyCredits(String id, String userId) async {
    _creditsView?.displayLoading();
    try {
      var user = await creditsRepo.buyCredits(id, userId);

      if (user != null) {
        _creditsView?.updateCredits(user.balance);

        if(_mainView != null) {
          _mainView!.displayPlayerProfile(user);
        }

      } else {
        _creditsView?.displayError(NoCreditsPurchasedException(""));
      }
    } catch(exception) {
      _creditsView?.displayError(ErrorDuringCreditsPurchasedException(""));
    }
  }

  @override
  void setCreditsView(CreditsView view) {
    _creditsView = view;
  }

  @override
  void setMainView(MainView view) {
    _mainView = view;
  }

  @override
  Future<int> getUserBalance(String userId) async {
    User? user = await auth.getUser();
    if(user != null) {
      return user.balance;
    } else {
      return -1;
    }
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