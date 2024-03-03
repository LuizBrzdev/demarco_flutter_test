import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/style/app_style_colors.dart';
import '../../utils/masks/masks_formatter.dart';

enum CTextFormType { none, date }

class CTextForm extends StatefulWidget {
  final double height;
  final double width;
  final CTextFormType type;
  final void Function(String value)? onChanged;
  final Function(String value)? onValidation;
  final String errorText;
  final int? maxLines;
  final String? hintText;
  final String label;
  final TextEditingController? controller;

  ///[inputFormatters] formata as mascaras de texto de acordo com o [CTextFormType]
  final List<TextInputFormatter>? inputFormatters;

  const CTextForm({
    super.key,
    this.maxLines,
    this.onChanged,
    this.onValidation,
    this.errorText = '',
    this.height = 60,
    this.hintText,
    this.width = double.infinity,
    this.inputFormatters,
    this.type = CTextFormType.none,
    required this.label,
    this.controller,
  });

  @override
  State<CTextForm> createState() => _CTextFormState();
}

class _CTextFormState extends State<CTextForm> {
  String? validationString;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: TextField(
            controller: widget.controller,
            inputFormatters: _returnInputFormatterMask(widget.type),
            maxLines: widget.maxLines,
            onChanged: (value) {
              widget.onChanged?.call(value);
              if (widget.onValidation != null) {
                final result = widget.onValidation!(value);
                setState(
                  () => validationString =
                      result ?? (widget.errorText.isNotEmpty ? widget.errorText : null),
                );
              }
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(width: 2, color: AppStyleColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(width: 2, color: AppStyleColors.primary),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(width: 2, color: Colors.red),
              ),
              labelText: widget.label,
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: AppStyleColors.primary, fontWeight: FontWeight.bold),
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
          ),
        ),
        Visibility(
          visible: (validationString != null || widget.errorText != ''),
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              validationString ?? widget.errorText,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppStyleColors.errorPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<TextInputFormatter>? _returnInputFormatterMask(CTextFormType? type) {
    switch (type) {
      case CTextFormType.date:
        return [MasksFormatter.date];
      default:
        return widget.inputFormatters;
    }
  }
}
