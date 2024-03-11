import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatelessWidget {
const Carousel({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return CarouselSlider(items: [
      Container(
         margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(8.0), 
                image: const DecorationImage( 
                  image: AssetImage('assets/images/shop_banner_1.webp'), 
                  fit: BoxFit.cover, 
                ), 
              ), 
        
      ),
    
      Container(
         margin: const EdgeInsets.all(6.0), 
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(8.0), 
                image: const DecorationImage( 
                  image: AssetImage('assets/images/project.jpg'), 
                  fit: BoxFit.cover, 
                ), 
              ), 
      ),
    
      Container(
         margin: const EdgeInsets.all(6.0), 
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(8.0), 
                image: const DecorationImage( 
                  image: AssetImage('assets/images/shop_banner_1.webp'),
                  fit: BoxFit.cover, 
                ), 
              ), 
      ),
    
      Container(
         margin: const EdgeInsets.all(6.0), 
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(8.0), 
                image: const DecorationImage( 
                  image: AssetImage('assets/images/shop_banner_1.webp'), 
                  fit: BoxFit.cover, 
                ), 
              ), 
      ),
    ], options: CarouselOptions( 
            height: 450.0, 
            enlargeCenterPage: true, 
            autoPlay: true, 
            aspectRatio: 16 / 9, 
            autoPlayCurve: Curves.fastOutSlowIn, 
            enableInfiniteScroll: true, 
            autoPlayAnimationDuration: Duration(milliseconds: 800), 
            viewportFraction: 0.8, 
          ), );
  }
}