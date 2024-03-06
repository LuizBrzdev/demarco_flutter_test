///[ValidationHelper] classe que auxilia na validação de formulário utilizando [ValidationMixin]
///age adicionando ou retirando campos a variável [_checkForms] através dos métodos  [addToCheckForm] e [removeToCheckForm].
///quando é necessário comparar se todos os campos estão presentes é utilizado [checkAllFormsAreValid] onde é passado um Lista de String com todos os campos necessários para efetivar a validação
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
