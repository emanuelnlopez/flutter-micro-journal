abstract class StringUtils {
  static final hashtagRegExp = RegExp(r"#(\w+[-\w]*)");

  static List<String> getTags(String input) {
    final tagMatches = hashtagRegExp.allMatches(input);
    final tags = tagMatches.map((match) => match.group(1)!).toList();
    return tags;
  }

  static String getText(String input) =>
      input.replaceAll(hashtagRegExp, '').trim();
}
