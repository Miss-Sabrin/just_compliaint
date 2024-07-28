import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Imageslider extends StatefulWidget {
  const Imageslider({super.key});

  @override
  _ImagesliderState createState() => _ImagesliderState();
}

class _ImagesliderState extends State<Imageslider> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: _isLoading
          ? _buildShimmer()
          : AnotherCarousel(
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
                colors: [Colors.black.withOpacity(0.999), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 250,
        color: Colors.white,
      ),
    );
  }
}
