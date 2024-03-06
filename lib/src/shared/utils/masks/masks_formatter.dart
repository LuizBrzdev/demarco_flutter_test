import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

///[MasksFormatter] formatador de  mascaras de input
class MasksFormatter {
  static final MaskTextInputFormatter date = MaskTextInputFormatter(mask: Masks.date);
}

///[Masks] mascaras, usadas nas formatações pela classe [MasksFormatter]
class Masks {
  static const String date = "##/##/####";
}
