import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final String text;
  final double widthBtn;

  const ActionButton({Key? key, required this.text, required this.widthBtn})
      : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7.0),
      height: 52,
      width: widget.widthBtn,
      decoration: BoxDecoration(
          color: const Color(0xFF9E7EE2),
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.28),
                offset: Offset(3, 3),
                blurRadius: 4.0)
          ]),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.5,
                fontWeight: FontWeight.bold),
          ),
          Image.asset(
            'assets/arrow-right.png',
            scale: 22.5,
          )
        ],
      )),
    );
  }
}
