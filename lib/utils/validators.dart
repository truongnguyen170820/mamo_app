class Validator {
  static final instance = Validator();

  bool isPassword(String value) {
    return value.isNotEmpty && value.length >= 6;
  }

  bool isPhoneNumber(String value) {
    String pattern = r'(^(?:[+0][9|3|8|7|1|5])?[0-9]{8,10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
  /*
Phone numbers must contain 10 digits.
In case country code us used, it can be 12 digits. (example country codes: +84, 012)
No space or no characters allowed between digits
 */
}
