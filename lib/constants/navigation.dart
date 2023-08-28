class NavigationRouteName {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const onBoardingName = '/onboarding-name';
  static const onBoardingSetupPin = '/onboarding-setup-pin';
  static const onBoardingConfirmPin = '/onboarding-confirm-pin';
  static const onBoardingOtpPin = '/onboarding-otp-pin';
  static const home = '/home';
  static const pin = '/pin';
  static const otp = '/otp';
  static const transactionHistory = '/transactionHistory';
  static const formSendMoney = '/formSendMoney';
  static const formCredit = '/formCredit';
  static const formElectricity = '/formElectricity';
  static const payment = '/payment';
  static const transactionProgress = '/transactionProgress';
  static const editProfile = '/editProfile';
  static const profile = '/profile';
  static const webView = '/webView';

  static String getName(String path) {
    if (!path.startsWith(RegExp(r'/'))) {
      return path;
    }
    return path.replaceFirst(RegExp(r'/'), '');
  }
}