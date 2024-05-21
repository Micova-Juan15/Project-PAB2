import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoItem({
    Key? key,
    required this.label,
    required this.value,

  }) : super(key: key);
  
@override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          ),
        ),
        const SizedBox(height: 10,),
          Expanded(
            child: Text(
              ': $value',
              style: const TextStyle(fontSize: 25, color: Colors.white),
          )
        ),
      ],
    );
  }
}