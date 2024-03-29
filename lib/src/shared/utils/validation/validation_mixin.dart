import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///[ValidationMixin] Mixin para validação de formulários
///quando a condição não for cumprida retorna uma string com o error, caso cumprida retorna null
///métodos [onInvalid] e [onValid]  são chamados de forma respectivas

mixin ValidationMixin {
  ///[isNotEmpty] verifica se o valor  não está vazio
  String? isNotEmpty(
    String? value, {
    String? message,
    VoidCallback? onInvalid,
    VoidCallback? onValid,
  }) {
    if (value == null || value.trim().isEmpty) {
      onInvalid?.call();
      return message ?? 'Campo obrigatório.';
    }
    onValid?.call();
    return null;
  }

  ///[isGreaterThan] verifica se o valor é menor ou igual ao valor máximo predeterminado
  String? isGreaterThan(
    String? value,
    int min, {
    String? message,
    VoidCallback? onInvalid,
    VoidCallback? onValid,
  }) {
    if (value!.trim().length <= min) {
      onInvalid?.call();
      return message ?? 'Campo deve ter no mínimo $min caracteres';
    }
    onValid?.call();
    return null;
  }

  ///[isValidDate] verifica se a data informada é valida e se não está no passado
  String? isValidDate(
    String? value, {
    String? message,
    VoidCallback? onInvalid,
    VoidCallback? onValid,
  }) {
    if (value == null || value.length != 10) {
      onInvalid?.call();
      return 'Data inválida';
    }

    int day = int.parse(value.substring(0, 2));
    int month = int.parse(value.substring(3, 5));
    int year = int.parse(value.substring(6, 10));

    if (day < 1 || day > 31 || month < 1 || month > 12 || year < 0) {
      onInvalid?.call();

      return message ?? 'Data inválida';
    }

    if (month == 2 && day > 29) {
      onInvalid?.call();
      return message ?? 'Data inválida';
    }

    final DateTime inputDate = DateFormat('dd/MM/yyyy')
        .parse(value)
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    if (inputDate.isBefore(DateTime.now())) {
      onInvalid?.call();
      return message ?? 'Data inválida';
    }

    onValid?.call();
    return null;
  }

  ///[combine] combina vários mais de 1 validador.
  ///<br>
  ///Exemplo:
  ///<br>
  /// onValidation: (value) => combine([
  ///    () => isNotEmpty(value),
  ///    () => isEmail(value),]),
  String? combine(
    List<String? Function()> validators, {
    VoidCallback? onInvalid,
    VoidCallback? onValid,
  }) {
    for (var validator in validators) {
      String? result = validator();
      if (result != null) {
        onInvalid?.call();
        return result;
      }
    }
    onValid?.call();
    return null;
  }
}
