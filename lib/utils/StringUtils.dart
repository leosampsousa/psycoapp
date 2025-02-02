class StringUtils {
  const StringUtils._();

  static bool hasUpperCase(String? string) {
    if (string == null || string.isEmpty) return false;

    List<String> characters = string.split("");
    for (String character in characters) {
      if (character == character.toUpperCase() && !_isNumeric(character)) {
        return true;
      }
    }
    return false;
  }

  static bool hasLowerCase(String? string) {
    if (string == null || string.isEmpty) return false;

    List<String> characters = string.split("");
    for (String character in characters) {
      if (character == character.toLowerCase() && !_isNumeric(character)) {
        return true;
      }
    }
    return false;
  }
}

bool _isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
