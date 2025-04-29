import 'package:flutter/material.dart';

class DescriptionCinema extends StatefulWidget {
  final double width;
  final double height;
  final String hintText;

  const DescriptionCinema({
    Key? key,
    required this.width,
    required this.height,
    required this.hintText,
  }) : super(key: key);

  @override
  DescriptionCinemaState createState() => DescriptionCinemaState();
}

class DescriptionCinemaState extends State<DescriptionCinema> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void validate() {
    setState(() {
      if (_controller.text.trim().isEmpty) {
        _errorText = 'هذا الحقل مطلوب';
      } else {
        _errorText = null;
      }
    });
  }

  String get descriptionText => _controller.text.trim(); // ⬅️ رجع النص

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.topLeft,
          child: TextField(
            controller: _controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 8),
            child: Text(
              _errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
