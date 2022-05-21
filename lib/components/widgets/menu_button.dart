import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Icon icon;
  final Function() onClick;
  final String text;
  const MenuButton(
      {Key? key, required this.icon, required this.onClick, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: ClipOval(
            child: Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                splashColor: Colors.white12,
                child: icon,
                onTap: onClick,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(text),
      ],
    );
  }
}
