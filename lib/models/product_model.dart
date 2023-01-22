import 'package:flutter/material.dart';

class Product {
  final String productname;
  final double productprice;
  final String productuploaddate;
  final String productimage;
  final String userId;
  final int phonenumber;
  final String productId;

  Product(
      {required this.productname,
      required this.productprice,
      required this.productuploaddate,
      required this.userId,
      required this.productimage,
      required this.phonenumber,
      required this.productId});
}
