import 'dart:core';

class Product{
  final int pid;
  final String name;
  final int quantity;
  final double price;
  final String category;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final List<String> images;

  Product(this.pid,this.name, this.quantity, this.price, this.category, this.description,
      this.sizes, this.colors, this.images);
}