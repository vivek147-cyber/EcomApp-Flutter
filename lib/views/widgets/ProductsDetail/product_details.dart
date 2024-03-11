import 'package:ecom_app/providers/cart_providers.dart';
import 'package:ecom_app/views/shared/navbar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final data;
  const ProductDetails({super.key, required this.data});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final String addToCart = 'Add To Cart';
  final String removeFromCart = 'Remove From Cart';


   @override
  void initState()
  {
    super.initState();
    Provider.of<Cart>(context,listen: false).getCartToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Navbar(),
          backgroundColor: Colors.white,
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
                              '\$${widget.data?.price.toStringAsFixed(2) ?? '0.00'}',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255), // Customize the color of the price
                              ),
                            ),
                     ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 33.0,
                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                    
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Shadow color
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset:
                                                  Offset(0, 3), // Shadow offset
                                            ),
                                          ],
                                        ),
                      child: TextButton(
                      
                        child: Center(
                          child: Text(
                            cart.isCart(widget.data?.id) ?
                             removeFromCart  : 
                             addToCart,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .toggle(widget.data?.id);
                                
                          Cart cartList = Provider.of<Cart>(context, listen: false);
                                
                          if (cart.isCart(widget.data?.id)) {
                            cartList.addToCart(widget.data);
                          } else {
                            cartList.removeFromCart(widget.data);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.data.image,
                  height: 350,
                  // fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 14,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),),
                  child: Container(
                    height: 380,
                    color: const Color.fromARGB(255, 247, 247, 247),
                    child: Padding(
                      padding:  EdgeInsets.only(top: 40.0, left: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),

                                        color: Color.fromARGB(255, 92, 119, 255),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.5), // Shadow color
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset:
                                                Offset(0, 3), // Shadow offset
                                          ),
                                        ],
                                      ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                              child: Text(
                                      widget.data?.category ?? 'test1',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 210,
                                  child: Text(
                                    widget.data?.title ?? 'test1',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 92, 119, 255),
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    '${widget.data?.rating?.rate ?? 0.0} (${widget.data?.rating?.count ?? 0} reviews)',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors
                                          .grey, // Customize the color of the rating
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                       
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Text(
                              widget.data?.description ?? 'test1',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Display price
                )
              ],
            ),
          ),
        ));
  }
}
