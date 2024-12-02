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

//recibe un numero y lo devuelve en romano (del 1 al 10)
String toRoman(int number) {
  if (number < 1 || number > 10) {
    throw ArgumentError('Number must be between 1 and 10');
  }

  switch (number) {
    case 1:
      return 'i';
    case 2:
      return 'ii';
    case 3:
      return 'iii';
    case 4:
      return 'iv';
    case 5:
      return 'v';
    case 6:
      return 'vi';
    case 7:
      return 'vii';
    case 8:
      return 'viii';
    case 9:
      return 'iv';
    case 10:
      return 'x';
    default:
      return '';
  }
}
