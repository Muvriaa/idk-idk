// lib/password_validator.dart
class PasswordValidator {
  /// Returns a list of error codes. Empty list => valid password.
  /// Possible error codes:
  /// - 'min_length'   : less than 8 characters
  /// - 'upper_lower'  : missing uppercase or lowercase
  /// - 'digit'        : missing digit
  /// - 'symbol'       : missing symbol (non-alphanumeric, non-space)
  /// - 'no_spaces'    : contains space(s)
  static List<String> validate(String password) {
    final errors = <String>[];

    // Rule: no spaces
    if (password.contains(' ')) {
      errors.add('no_spaces');
    }

    // Rule: at least 8 characters
    if (password.length < 8) {
      errors.add('min_length');
    }

    // Rule: upper + lower case
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    if (!(hasUpper && hasLower)) {
      errors.add('upper_lower');
    }

    // Rule: contains digit
    final hasDigit = RegExp(r'\d').hasMatch(password);
    if (!hasDigit) {
      errors.add('digit');
    }

    // Rule: contains symbol (non-word and not whitespace)
    // Using [^\w\s] matches characters that are not word characters (\w) and not whitespace (\s).
    // That captures punctuation and symbols. Underscore is a word character, so it's not counted as symbol.
    final hasSymbol = RegExp(r'[^\w\s]').hasMatch(password);
    if (!hasSymbol) {
      errors.add('symbol');
    }

    return errors;
  }

  /// Convenience boolean check.
  static bool isValid(String password) => validate(password).isEmpty;
}
