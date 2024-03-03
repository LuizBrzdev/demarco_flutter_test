class ValidationHelper {
  final Set<String> _checkForms = <String>{};
  Set<String> get checkForms => _checkForms;

  void addToCheckForm(String form) {
    _checkForms.add(form);
  }

  void removeToCheckForm(String form) {
    if (_checkForms.contains(form)) {
      _checkForms.remove(form);
    }
  }

  bool checkAllFormsAreValid(List<String> validForms) => _checkForms.containsAll(validForms);
}
