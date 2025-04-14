import 'package:flutter/material.dart';
import '../Resources/colors.dart';

class KSearchbar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onClear;

  const KSearchbar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onFieldSubmitted,
    this.onClear,
  });

  @override
  State<KSearchbar> createState() => _KSearchbarState();
}

class _KSearchbarState extends State<KSearchbar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: widget.controller,
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(Kolor.scaffold),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 15, vertical: 5).copyWith(right: 5),
      ),
      hintText: widget.hintText,
      hintStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 17, color: Kolor.fadeText, height: 1.5),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: 17,
          fontVariations: [FontVariation.weight(500)],
          height: 1.5,
        ),
      ),
      leading: Icon(Icons.search),
      side: WidgetStatePropertyAll(BorderSide(color: Kolor.border)),
      trailing: [
        IconButton.filledTonal(
          onPressed: () => widget.onFieldSubmitted!(widget.controller.text),
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
