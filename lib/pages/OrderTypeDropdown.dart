import 'package:flutter/material.dart';

class OrderTypeDropdown extends StatelessWidget {
  final Function(int?) onChange;
  final int selectedJobType;
  const OrderTypeDropdown({Key? key, required this.onChange, required this.selectedJobType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.indigo,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(25, 0, 0, 0),
                blurRadius: 4,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButton<int>(
            style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
            dropdownColor: Colors.indigo,
            isExpanded: true,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem<int>(
                child: Text('SO dan DO'),
                value: 1,
              ),
              DropdownMenuItem<int>(
                child: Text('SO'),
                value: 2,
              ),
              DropdownMenuItem<int>(
                child: Text('DO'),
                value: 3,
              ),
            ],
            onChanged: onChange,
            value: selectedJobType,
          ),
        ),
      ),
    );
  }
}
