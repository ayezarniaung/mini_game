import 'package:flutter/material.dart';

class ItemModel {
  final IconData icon;
  final String item;
  final String value;
  bool accepting;
  ItemModel({
    required this.item,
    required this.value,
    required this.icon,
    required this.accepting,
  });
}
