import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget{
  const MealItemTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon),
          const SizedBox(width: 2,),
          Text(label,style: const TextStyle(color: Colors.white),),
        ],
      ),
    );
  }

}