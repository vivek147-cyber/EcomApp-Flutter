import 'package:ecom_app/providers/cart_providers.dart';
import 'package:ecom_app/providers/wishlist_providers.dart';
import 'package:ecom_app/responsive/responsive_layout.dart';
import 'package:ecom_app/views/screens/HomePage.dart';
import 'package:ecom_app/views/screens/wishListPage.dart';
import 'package:ecom_app/views/shared/mobile_common_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/screens/ProductsPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [ //wrapping the widget by making the provider object
        ChangeNotifierProvider<WishList>(create: (_)=> WishList()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        routes: {
          '/':(context) => Responsive.isDesktop(context) && kIsWeb
            ?  const HomePage()
            : MobileCommonScreen(),
          '/products': (context) => const ProductsPage(),
          '/wishlist': (context) => const WishListPage(),
          // Add more routes as needed
        },
        // home: Responsive.isDesktop(context)
        //     ?  const HomePage()
        //     : MobileCommonScreen(),
        
      ),
    );
  }
}
