import 'package:ecom_app/providers/cart_providers.dart';
import 'package:ecom_app/responsive/responsive_layout.dart';
import 'package:ecom_app/views/screens/CartPage.dart';
import 'package:ecom_app/views/shared/nav_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final String Home = 'Home';
  final String Products = 'Products';
  final String wishlist = 'wishlist';

  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: _mobileNavBar(), desktop: _desktopNavBar());
  }

  //Navbar for desktop
  Widget _desktopNavBar() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('ShopIt'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(title: Home, route: '/'),
            const SizedBox(width: 8),
            NavItem(title: Products, route: '/products'),
            const SizedBox(width: 8),
            NavItem(title: wishlist, route: '/wishlist'),
            const SizedBox(width: 8),
            Consumer<Cart>(
                builder: (context, cart, _) => badges.Badge(
                      badgeContent: Text('${cart.cartList.length}'),
                      position: badges.BadgePosition.topEnd(top: -1, end: -1),
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Color.fromARGB(255, 255, 180, 180),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.shopping_bag,
                          color: Color.fromARGB(195, 0, 0, 0),
                          size: 28,
                        ),
                        onPressed: () {
                          navigateToCartPage();
                        },
                      ),
                    )),
          ],
        )
      ]),
    );
  }

  //Navbar for mobile

  Widget _mobileNavBar() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('ShopIt'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(
              title: wishlist,
              route: '',
            ),
            const SizedBox(width: 8),
            Consumer<Cart>(
                builder: (context, cart, _) => badges.Badge(
                      badgeContent: Text('${cart.cartList.length}'),
                      position: badges.BadgePosition.topEnd(top: -1, end: -1),
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Color.fromARGB(255, 255, 180, 180),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.shopping_bag,
                          color: Color.fromARGB(195, 0, 0, 0),
                          size: 28,
                        ),
                        onPressed: () {
                          navigateToCartPage();
                        },
                      ),
                    )),
          ],
        )
      ]),
    );
  }

  void navigateToCartPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartPage()));
  }
}
