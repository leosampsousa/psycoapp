class ValidationUtils {
  const ValidationUtils._();

  static String? fieldRequiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo é obrigatório';
    }
    return null;
  }
}
