class Validator {
  static String? validatorFullName(value) {
    if (value!.isEmpty) {
      return 'Please enter your full name';
    } else if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
      return 'Please enter a valid name ';
    }
    return null;
  }

  static String? validatorEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatorPassword(value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? validatorPhoneNumber(value) {
    if (value!.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
