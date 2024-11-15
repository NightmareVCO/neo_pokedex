String toTitleCase(String str) {
  List<String> words = str.split(' ');
  List<String> titleCaseWords = words.map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    } else {
      return word;
    }
  }).toList();
  return titleCaseWords.join(' ');
}

//Convert medium-slow to Medium Slow or medium_slow to Medium Slow, or any other string with a dash or underscore
String toTitleCaseWithSpaces(String str) {
  List<String> words = str.split(RegExp(r'[-_]'));
  List<String> titleCaseWords = words.map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    } else {
      return word;
    }
  }).toList();
  return titleCaseWords.join(' ');
}

//"Spits fire that\nis hot enough to\nmelt boulders.\fKnown to cause\nforest fires\nunintentionally." to
//"Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally."
String removeNewLines(String str) {
  return str.replaceAll('\n', ' ').replaceAll('\f', ' ');
}
