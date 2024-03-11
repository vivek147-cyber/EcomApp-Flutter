import 'package:ecom_app/models/products_models.dart';
import 'package:ecom_app/providers/wishlist_providers.dart';
import 'package:ecom_app/responsive/responsive_layout.dart';
import 'package:ecom_app/views/shared/common_screen.dart';

import 'package:ecom_app/views/shared/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<WishList>(context, listen: false).getCartToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Responsive(
          mobile: _mobileWishListPage(), desktop: _desktopWishlistPage()),
    );
  }

  void _navigateToProductPage(param0) {}

  _desktopWishlistPage() {
    return CommonScreen(
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Consumer<WishList>(
            builder: (context, favList, child) {
              return ListView.builder(
                  itemCount: favList.wishList.length,
                  itemBuilder: ((context, index) {
                    Products? product = favList.wishList[index];
                    return Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 550,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45.0, top: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: CachedNetworkImage(
                                  imageUrl: product!.image!,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                                      Container(
                                        width: 80.0,
                                        child: Text(
                                          _truncateTitle(
                                              product?.title ?? 'test1', 2),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 92, 119, 255),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '\$${(product?.price ?? 0)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 92, 119, 255),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<WishList>(
                                    builder: (context, favorite, _) =>
                                        IconButton(
                                          icon: Icon(
                                            favorite.isFav(product?.id)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:
                                                Color.fromARGB(195, 255, 0, 0),
                                            size: 28,
                                          ),
                                          onPressed: () {
                                            Provider.of<WishList>(context,
                                                    listen: false)
                                                .toggle(product.id);

                                            WishList favcartlist =
                                                Provider.of<WishList>(context,
                                                    listen: false);

                                            if (favorite.isFav(product.id)) {
                                              favcartlist
                                                  .addToWishList(product);
                                            } else {
                                              favcartlist
                                                  .removeFromWishList(product);
                                            }
                                          },
                                        ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
            },
          )),
    );
  }

  _mobileWishListPage() {
    return Padding(
          padding: EdgeInsets.all(10.0),
          child: Consumer<WishList>(
            builder: (context, favList, child) {
              return ListView.builder(
                  itemCount: favList.wishList.length,
                  itemBuilder: ((context, index) {
                    Products? product = favList.wishList[index];
                    return Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 550,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child:  Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: CachedNetworkImage(
                                  imageUrl: product!.image!,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                                      Padding(
                                padding: const EdgeInsets.only(
                                    left: 45.0, top: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 80.0,
                                      child: Text(
                                        _truncateTitle(
                                            product?.title ?? 'test1', 2),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 92, 119, 255),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${(product?.price ?? 0)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 92, 119, 255),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                Consumer<WishList>(
                                    builder: (context, favorite, _) =>
                                        Padding(
                                          padding: const EdgeInsets.only(left: 50.0),
                                          child: IconButton(
                                            icon: Icon(
                                              favorite.isFav(product?.id)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:
                                                  Color.fromARGB(255, 255, 180, 180),
                                              size: 28,
                                            ),
                                            onPressed: () {
                                              Provider.of<WishList>(context,
                                                      listen: false)
                                                  .toggle(product.id);
                                          
                                              WishList favcartlist =
                                                  Provider.of<WishList>(context,
                                                      listen: false);
                                          
                                              if (favorite.isFav(product.id)) {
                                                favcartlist
                                                    .addToWishList(product);
                                              } else {
                                                favcartlist
                                                    .removeFromWishList(product);
                                              }
                                            },
                                          ),
                                        ))
                              ],
                            ),
                          ),
                              
                        ),
                      ),
                    
                      );
                  }));
            },
          ));
  }

  String _truncateTitle(String title, int words) {
    List<String> titleWords = title.split(' ');
    if (titleWords.length <= words) {
      return title;
    } else {
      return titleWords.sublist(0, words).join(' ');
    }
  }
}
