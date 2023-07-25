class NavigationRouteName {
  static const splash = '/';
  static const login = 'login';
  static const register = 'register';
  static const home = 'home';
  static const pin = 'pin';
  static const otp = 'otp';
  static const transactionHistory = 'transactionHistory';
  static const formSendMoney = 'formSendMoney';
  static const formCredit = 'formCredit';
  static const formElectricity = 'formElectricity';
  static const payment = 'payment';
  static const transactionProgress = 'transactionProgress';
  static const profile = 'profile';
  static const webView = 'webView';

  static String getPath(String routeName) {
    if (routeName.startsWith(RegExp(r'/'))) {
      return routeName;
    }
    return '/$routeName';
  }
}