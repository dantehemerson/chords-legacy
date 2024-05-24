import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_drive/utils/locale_utils.dart';

void main() {
  group('LocaleUtils', () {
    test('should parse locales from string correctly', () {
      const testData = [
        {'input': 'en_US', 'output': Locale('en')},
        {'input': 'en-US', 'output': Locale('en')},
        {'input': 'fr-FR', 'output': Locale('fr')},
        {'input': 'es', 'output': Locale('es')},
        {'input': 'es_PE', 'output': Locale('es')},
        {'input': 'es_PE-UTF8', 'output': Locale('es')},
      ];

      for (final data in testData) {
        final locale = data['input'] as String;
        final expected = data['output'] as Locale;

        expect(
          LocaleUtils.toLocale(locale)?.languageCode,
          equals(expected.languageCode),
        );
      }
    });
  });
}
