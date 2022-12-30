import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmitFunc;
  final String hintTxt;
  const SearchBar(this.controller, this.onSubmitFunc,
      {super.key, this.hintTxt = ''});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search, color: Color(0xFFD3D3D3), // FFEEEEEE
        ),
        hintText: hintTxt,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 16.0,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD3D3D3), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      onSubmitted: (value) {
        onSubmitFunc(value);
      },
      controller: controller,
    );
  }
}
