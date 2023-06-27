class LanguageEntity {
  final String code;
  final String value;

  const LanguageEntity({
    required this.code,
    required this.value,
  });
}

class Languages {
  const Languages._();

  // Languages supported
  static const languages = [
    LanguageEntity(code: 'en', value: 'ENGLISH'),
    LanguageEntity(code: 'gu', value: 'ગુજરાતી'),
    LanguageEntity(code: 'hi', value: 'हिन्दी'),
    // LanguageEntity(code: 'ar', value: 'AE'),
  ];
}
