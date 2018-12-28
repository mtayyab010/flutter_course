import 'package:flutter/material.dart';

class Product {
  String title;
  String description;
  double price;
  String image;

  Product(
      {@required this.title,
      @required this.description,
      @required this.price,
      @required this.image});
}
