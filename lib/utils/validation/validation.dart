String validateMobile(String value) {
  value =
      value.replaceAll(RegExp(r'[^0-9]'), '').replaceFirst(RegExp(r'62'), '0');
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty || value.length <= 9) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return '';
}
