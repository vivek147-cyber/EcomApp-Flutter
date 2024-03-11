import 'dart:async';

import 'package:ecom_app/providers/cart_providers.dart';
import 'package:ecom_app/providers/wishlist_providers.dart';
import 'package:ecom_app/services/PushNotificationService.dart';
import 'package:ecom_app/views/widgets/Homepage/carousel.dart';
import 'package:ecom_app/views/widgets/Homepage/featured_products.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../responsive/responsive_layout.dart';
import '../shared/common_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //  String notificationTitle = 'No Title';
  // String notificationBody = 'No Body';
  // String notificationData = 'No Data';

 FCM notificationservices = FCM();

   @override
  void initState()
  {

    super.initState();
    notificationservices.requestNotificartionPermissions();
    notificationservices.FirebaseInit();
    notificationservices.isTokenRefresh();
    notificationservices.getDeviceToken().then((value) => print(value));
    Provider.of<WishList>(context,listen: false).getCartToPreferences();
    Provider.of<Cart>(context,listen: false).getCartToPreferences();
  }

  //   _changeData(String msg) => setState(() => notificationData = msg);
  // _changeBody(String msg) => setState(() => notificationBody = msg);
  // _changeTitle(String msg) => setState(() => notificationTitle = msg);

  @override
  Widget build(BuildContext context) {
     notificationservices.getDeviceToken().then((value) => print(value));
    return Scaffold(
      body: Responsive(mobile: _mobileHomePage(), desktop: _desktopHomePage()),
    );
  }

  // homepage for desktop
  Widget _desktopHomePage() {
    return CommonScreen(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Carousel(),
            ),
            
            Padding(
              padding: EdgeInsets.all(14.0),
              child: FeaturedProducts(),
            ),
            SizedBox(height: 16.0), // Add some space at the bottom
          ],
        ),
      ),
    );
  }

  // homepage for mobile
  Widget _mobileHomePage() {
     return  const SingleChildScrollView(
        child: Column(
          children: [
          
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Carousel(),
            ),
         
            Padding(
              padding: EdgeInsets.all(14.0),
              child: FeaturedProducts(),
            ),
            SizedBox(height: 16.0), // Add some space at the bottom
          ],
        ),
     
    );
  }
}
