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

  static String removeWhitespaces(String string) {
    if (string.contains(" ")) {
      string = string.replaceFirst(" ", "");
    }
    return string;
  }

  static bool isLowerAlphanumeric(String? string) {
    if (string != null && string.isNotEmpty) {
      return RegExp(r'^[a-z0-9]+$').hasMatch(string);
    }
    return true;
  }

  static bool _isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
