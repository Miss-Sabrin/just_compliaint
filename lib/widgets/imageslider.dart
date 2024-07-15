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
    return Stack(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100, // Adjust the height as needed
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
