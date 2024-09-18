class TypeHelpers {
  static int typeInt(num value) {
    try {
      if (value is int) {
        return value;
      } else {
        return value.toInt();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
