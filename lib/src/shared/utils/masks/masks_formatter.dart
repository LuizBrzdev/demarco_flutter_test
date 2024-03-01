import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MasksFormatter {
  static final MaskTextInputFormatter date = MaskTextInputFormatter(mask: Masks.date);
}

class Masks {
  static const String date = "##/##/####";
}
