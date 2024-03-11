import 'package:ecom_app/models/products_models.dart';
import 'package:ecom_app/providers/cart_providers.dart';
import 'package:ecom_app/responsive/responsive_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<Cart>(context, listen: false).getCartToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Consumer<Cart>(
          builder: (context, cart, _) => BottomAppBar(
            color: Color.fromARGB(255, 92, 119, 255),
            height: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Total: \$${cart.calculateTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255,
                          255), // Customize the color of the price
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: 33.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow offset
                        ),
                      ],
                    ),
                    child: TextButton(
                      child: const Center(
                        child: Text(
                          'Check out',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Responsive(mobile: _mobileCartPage(), desktop: _desktopCartPage()),
    );
  }

  _mobileCartPage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      child: Container(
        color: const Color.fromARGB(255, 247, 247, 247),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Consumer<Cart>(
            builder: (context, cart, child) {
              return ListView.builder(
                itemCount: cart.cartList.length,
                itemBuilder: ((context, index) {
                  Products? product = cart.cartList[index];
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
                                padding: const EdgeInsets.only(left: 15.0),
                                child: CachedNetworkImage(
                                  imageUrl: product!.image,
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
                                        _truncateTitle(product.title, 2),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 92, 119, 255),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${(product.price) * (product.quantity)}',
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
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: kIsWeb
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),

                                              color: Colors
                                                  .white, // Background color
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(
                                                          0.5), // Shadow color
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(
                                                      0, 3), // Shadow offset
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              iconSize: 16.0,
                                              icon: Icon(Icons.remove),
                                              onPressed: () {
                                                if (product.quantity > 1) {
                                                  Provider.of<Cart>(context,
                                                          listen: false)
                                                      .decrementQuantity(
                                                          product);
                                                }
                                              },
                                              color: Colors.black, // Icon color
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            '${product.quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: const Color.fromARGB(
                                                  255,
                                                  171,
                                                  213,
                                                  237), // Background color
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(
                                                          0.5), // Shadow color
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(
                                                      0, 3), // Shadow offset
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              iconSize: 16.0,
                                              icon: Icon(Icons.add),
                                              onPressed: () {
                                                Provider.of<Cart>(context,
                                                        listen: false)
                                                    .incrementQuantity(product);
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),

                                              color: Colors
                                                  .white, // Background color
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(
                                                          0.5), // Shadow color
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(
                                                      0, 3), // Shadow offset
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              iconSize: 16.0,
                                              icon: Icon(Icons.remove),
                                              onPressed: () {
                                                if (product.quantity > 1) {
                                                  Provider.of<Cart>(context,
                                                          listen: false)
                                                      .decrementQuantity(
                                                          product);
                                                }
                                              },
                                              color: Colors.black, // Icon color
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            '${product.quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: const Color.fromARGB(
                                                  255,
                                                  171,
                                                  213,
                                                  237), // Background color
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(
                                                          0.5), // Shadow color
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(
                                                      0, 3), // Shadow offset
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              iconSize: 16.0,
                                              icon: Icon(Icons.add),
                                              onPressed: () {
                                                Provider.of<Cart>(context,
                                                        listen: false)
                                                    .incrementQuantity(product);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: IconButton(
                                  icon: Icon(
                                    cart.isCart(product?.id)
                                        ? Icons.delete
                                        : Icons.delete,
                                    color: Color.fromARGB(195, 255, 0, 0),
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    Provider.of<Cart>(context, listen: false)
                                        .toggle(product.id);

                                    Cart cartList = Provider.of<Cart>(context,
                                        listen: false);

                                    if (cart.isCart(product.id)) {
                                      cartList.addToCart(product);
                                    } else {
                                      cartList.removeFromCart(product);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }

  _desktopCartPage() {
    return _mobileCartPage();
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
