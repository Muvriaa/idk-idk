// test/password_validator_test.dart
import 'package:test/test.dart';
import 'package:password_validator_tdd/password_validator.dart';

void main() {
  group('PasswordValidator (TDD rules added one-by-one)', () {
    test('fails if shorter than 8 characters', () {
      final errors = PasswordValidator.validate('Ab1!');
      expect(errors, contains('min_length'));
    });

    test('passes length >= 8', () {
      final errors = PasswordValidator.validate('Abcd123!');
      expect(errors, isNot(contains('min_length')));
    });

    test('requires both uppercase and lowercase', () {
      expect(PasswordValidator.validate('abcdefg1!'), contains('upper_lower'));
      expect(PasswordValidator.validate('ABCDEFG1!'), contains('upper_lower'));
      expect(PasswordValidator.validate('Abcdefg1!'), isNot(contains('upper_lower')));
    });

    test('requires at least one digit', () {
      expect(PasswordValidator.validate('Abcdefgh!'), contains('digit'));
      expect(PasswordValidator.validate('Abcdefg1!'), isNot(contains('digit')));
    });

    test('requires at least one symbol (non-alphanumeric, not space)', () {
      expect(PasswordValidator.validate('Abcdefg12'), contains('symbol'));
      expect(PasswordValidator.validate('Abcdefg1!'), isNot(contains('symbol')));
      // underscore is considered a word char, so treat punctuation as symbol
      expect(PasswordValidator.validate('Abcdefg1_'), contains('symbol')); // if you treat underscore as invalid symbol — see note
    });

    test('no spaces allowed', () {
      expect(PasswordValidator.validate('Abc def1!'), contains('no_spaces'));
      expect(PasswordValidator.validate('Abcdef1!'), isNot(contains('no_spaces')));
    });

    test('valid password returns empty error list', () {
      final errors = PasswordValidator.validate('GoodPass1!');
      expect(errors, isEmpty);
    });
  });
}

