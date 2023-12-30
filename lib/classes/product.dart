import 'dart:core';

import 'package:ecommerce/classes/Colors.dart';
import 'package:ecommerce/classes/Images.dart';
import 'package:ecommerce/classes/Sizes.dart';

class Product {
  int pid;
  String name;
  int quantity;
  double price;
  String category;
  List<SizesClass> sizes;
  List<ColorsClass> colors;
  List<ImagesClass> images;
  Product(this.pid, this.name, this.quantity, this.price, this.category,
      this.sizes, this.colors, this.images);
}
