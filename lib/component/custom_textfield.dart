import 'package:scheduler2024/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final isAboutTime;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  const CustomTextField(
      {required this.label,
        required this.isAboutTime,
        required this.onSaved,
        required this.validator,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: PRIMARY),
        ),
        Expanded(
          flex: isAboutTime ? 0 : 1,
          child: TextFormField(
            onSaved: onSaved,
            validator: validator,
            maxLines: isAboutTime ? 1 : null,
            keyboardType:
            isAboutTime ? TextInputType.number : TextInputType.multiline,
            cursorColor: Colors.grey,
            expands: !isAboutTime,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[300],
              suffixText: isAboutTime ? '시' : null,
            ),
            inputFormatters:
            isAboutTime ? [FilteringTextInputFormatter.digitsOnly] : [],
          ),
        ),
      ],
    );
  }
}
