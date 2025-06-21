import 'package:flutter/material.dart';

class MyDropdownWidget extends StatefulWidget {
  final String text;
  final List<String> items;
  final Function(String?) onChanged;
  const MyDropdownWidget({super.key, required this.text, required this.items, required this.onChanged});

  @override
  State<MyDropdownWidget> createState() => _MyDropdownWidgetState();
}

class _MyDropdownWidgetState extends State<MyDropdownWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      value: selectedValue,
      onChanged: widget.onChanged,
      items:
          widget.items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
    );
  }
}
