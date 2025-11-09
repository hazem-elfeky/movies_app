String? validInput(String? val, int min, int max, String type) {
  if (val == null || val.isEmpty) {
    return "can't be Empty";
  }

  if (type == "username") {
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(val)) {
      return "not valid username";
    }
  }

  if (type == "email") {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
      return "not valid email";
    }
  }

  if (type == "phone") {
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(val)) {
      return "not valid phone";
    }
  }

  if (val.length < min) {
    return "can't be less than $min";
  }

  if (val.length > max) {
    return "can't be larger than $max";
  }

  return null;
}
