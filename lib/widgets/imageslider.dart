import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class Imageslider extends StatelessWidget {
  const Imageslider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: AnotherCarousel(
        images: [
          _buildImageWithShadow('images/image2.jpg'),
          _buildImageWithShadow('images/image1.jfif'),
          _buildImageWithShadow('images/image3.jfif'),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        borderRadius: true,
        radius: Radius.circular(10),
      ),
    );
  }

  Widget _buildImageWithShadow(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
